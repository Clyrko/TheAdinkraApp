import Foundation
import UIKit
import CoreML
import Vision
import ImageIO

private enum Constants {
    static let cornerRadius: CGFloat = 8
}

class ScanViewController: BaseViewController {
    private let navBar = PopOverNavigationBar()
    private var imagePicker = UIImagePickerController()
    private var imageView = UIImageView()
    private var selectPhotoButton: StyleButton!
    private var symbolNameLabel: StyleLabel!
    private var adinkraModel: VNCoreMLModel!
    
    init(with model: VNCoreMLModel) {
        adinkraModel = model
        super.init()
    }
    
    lazy var detectionRequest: VNCoreMLRequest = {
        do {
            let request = VNCoreMLRequest(model: adinkraModel!, completionHandler: { [weak self] request, error in
                self?.processDetections(for: request, error: error)
            })
            request.imageCropAndScaleOption = .scaleFit
            return request
        }
//        catch {
//            fatalError("Failed to load Vision ML model: \(error)")
//        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        layoutConstraint()
    }
    
    private func showPicker() {
        let alert = UIAlertController(
            title: "Choose Image", message: nil,
            preferredStyle: .actionSheet
        )
        alert.addAction(UIAlertAction(
            title: "Camera",
            style: .default,
            handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(
            title: "Photo Library",
            style: .default,
            handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(
            title: "Cancel",
            style: .cancel,
            handler: nil
        ))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(
                title: "Warning",
                message: "You don't have camera",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        else {
            let alert  = UIAlertController(
                title: "Warning",
                message: "You don't have permission to access gallery.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func updateDetections(for image: UIImage) {
        let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue))
        guard let ciImage = CIImage(image: image) else { fatalError("Unable to create \(CIImage.self) from \(image).") }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation!)
            do {
                try handler.perform([self.detectionRequest])
            } catch {
                print("Failed to perform detection.\n\(error.localizedDescription)")
            }
        }
    }
    
    private func processDetections(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            guard let results = request.results else {
                print("Unable to detect anything.\n\(error!.localizedDescription)")
                return
            }
            
            let detections = results as! [VNRecognizedObjectObservation]
            self.drawDetectionsOnPreview(detections: detections)
        }
    }
    
    func drawDetectionsOnPreview(detections: [VNRecognizedObjectObservation]) {
        guard let image = self.imageView.image else {
            return
        }
        
        let imageSize = image.size
        let scale: CGFloat = 0
        UIGraphicsBeginImageContextWithOptions(imageSize, false, scale)
        
        image.draw(at: CGPoint.zero)
        
        for detection in detections {
            let preditiion = detection.labels.map({"\($0.identifier)"}).first
            symbolNameLabel?.text = preditiion
            print(detection.labels.map({"\($0.identifier)"}).count)
//            print(detection.labels.map({"\($0.identifier)"}).first)
            
            let boundingBox = detection.boundingBox
            let rectangle = CGRect(x: boundingBox.minX*image.size.width, y: (1-boundingBox.minY-boundingBox.height)*image.size.height, width: boundingBox.width*image.size.width, height: boundingBox.height*image.size.height)
            UIColor(red: 0, green: 1, blue: 0, alpha: 0.4).setFill()
            UIRectFillUsingBlendMode(rectangle, CGBlendMode.normal)
        }
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.imageView.image = newImage
    }
    
    private func showProfileScreen() {
        let controller = applicationDIProvider.makeProfileViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - LAYOUT
extension ScanViewController {
    private func initializeView() {
        navBar.onBackAction = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        navBar.onProfileAction = { [weak self] in
            self?.showProfileScreen()
        }
        navBar.title = "Scan"
        
        selectPhotoButton = .init(with: .primaryDefault, title: "Select Photo")
        selectPhotoButton.dropCorner(Constants.cornerRadius)
        selectPhotoButton.backgroundColor = .mainOrange
        selectPhotoButton.titleColor = .styleWhite
        selectPhotoButton.onTapAction = { [weak self] in
            self?.showPicker()
        }
        
        imageView.image = .init(systemName: "viewfinder")
        imageView.tintColor = .styleGray
        imageView.contentMode = .scaleAspectFit
        imageView.dropCorner(8)
        
        symbolNameLabel = .init(
            with: .bodyMainRegular,
            textColor: .styleBlack,
            textAlignment: .center,
            text: "Please take a picture or select an image from your Photo Library to begin identification"
        )
        
        view.addSubview(navBar)
        view.addSubview(imageView)
        view.addSubview(symbolNameLabel)
        view.addSubview(selectPhotoButton)
    }
    
    private func layoutConstraint() {
        navBar.layout {
            $0.top == view.topAnchor
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
        }
        
        imageView.layout {
            $0.top == navBar.bottomAnchor + 20
            $0.leading == view.leadingAnchor + 20
            $0.trailing == view.trailingAnchor - 20
            $0.height |=| 300
        }
        
        symbolNameLabel.layout {
            $0.top == imageView.bottomAnchor + 40
            $0.leading == view.leadingAnchor + 20
            $0.trailing == view.trailingAnchor - 20
        }
        
        selectPhotoButton.layout {
            $0.leading == view.leadingAnchor + 20
            $0.trailing == view.trailingAnchor - 20
            $0.bottom == view.bottomAnchor - 40
            $0.height |=| 48
        }
    }
}

extension ScanViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        
        self.imageView.image = image
        updateDetections(for: image)
        picker.dismiss(animated: true)
    }
}

import Foundation
import UIKit
import CoreML
import Vision
import ImageIO
import AdinkraAppMLModel

private enum Constants {
    static let cornerRadius: CGFloat = 8
}

class ScanViewController: BaseViewController {
    private var imagePicker = UIImagePickerController()
    private var imageView = UIImageView()
    private var selectPhotoButton: StyleButton!
    private var symbolNameLabel: StyleLabel!
//    private var modelTest = AdinkraAppMLModel.AdinkraAppObjectDetectionOne().model
    
    
    lazy var detectionRequest: VNCoreMLRequest = {
        do {
//            Line that should work
//            let model = try VNCoreMLModel(for: AdinkraAppObjectDetectionOne().model)
            
            let model = try VNCoreMLModel(for: AdinkraAppMLModel.AdinkraAppObjectDetectionOne().model)
//            let model = try VNCoreMLModel(for: modelTest)


            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                self?.processDetections(for: request, error: error)
            })
            request.imageCropAndScaleOption = .scaleFit
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        layoutConstraint()
    }
    
    private func showPicker() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
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
    
    
}

//MARK: - LAYOUT
extension ScanViewController {
    private func initializeView() {
        
        selectPhotoButton = .init(with: .primaryDefault, title: "Select Photo")
        selectPhotoButton.dropCorner(Constants.cornerRadius)
        selectPhotoButton.backgroundColor = .mainOrange
        selectPhotoButton.titleColor = .styleWhite
        selectPhotoButton.onTapAction = { [weak self] in
            self?.showPicker()
        }
        
        imageView.contentMode = .scaleAspectFit
        
        symbolNameLabel = .init(
            with: .header2,
            textColor: .mainOrange,
            textAlignment: .center,
            text: "Hello"
        )
        
        view.addSubview(imageView)
        view.addSubview(symbolNameLabel)
        view.addSubview(selectPhotoButton)
    }
    
    private func layoutConstraint() {
        imageView.layout {
            $0.top == view.topAnchor + 40
            $0.leading == view.leadingAnchor + 20
            $0.trailing == view.trailingAnchor - 20
            $0.height |=| 400
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
        picker.dismiss(animated: true)

        guard let image = info[.originalImage] as? UIImage else {
            return
        }

        self.imageView.image = image
        updateDetections(for: image)
    }
}

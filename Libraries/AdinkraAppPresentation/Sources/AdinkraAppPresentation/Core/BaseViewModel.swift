import Combine
//import AdinkraDomain
import Foundation

public protocol BaseViewModelProtocol {
    var onError: PassthroughSubject<String, Never> { get }
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisAppear()
    func cancelTasks()
}

public class BaseViewModel: BaseViewModelProtocol {
    public var onError: PassthroughSubject<String, Never> = .init()
    var tasks: Set<Task<Void, Never>> = .init()
    func handle(error: Error) {
//        if error is UnAuthorizedError {
//            //Log user out
//        }else{
//            onError.send((error as? DomainErrorProtocol)?.message ?? "Unknown error occurred")
//        }
    }
    
    func doBlock(_ action: (() async throws -> Void)?) async {
        do {
            try await action?()
        } catch {
            handle(error: error)
        }
    }
}

@objc 
extension BaseViewModel {
    public func viewDidLoad() {}
    
    public func viewWillAppear() {}
    
    public func viewDidAppear() {}
    
    public func viewWillDisAppear() {}
    
    public func cancelTasks() {
        tasks.forEach { $0.cancel() }
    }
}

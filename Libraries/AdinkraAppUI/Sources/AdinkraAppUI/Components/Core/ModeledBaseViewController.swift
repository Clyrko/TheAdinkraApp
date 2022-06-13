import AdinkraAppPresentation

class ModeledBaseViewController<ViewModel: BaseViewModelProtocol>: BaseViewController {
    var viewModel: ViewModel
    
    init(with viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.viewWillDisAppear()
    }
    
    private func bind() {
        viewModel.onError.sink { [weak self] error in
            self?.hideLoader()
            self?.showAlert(with: "Error", message: error, actions: [])
        }.store(in: &subscriptions)
    }
    
    deinit {
        viewModel.cancelTasks()
    }
}


import UIKit

final class BoxOfficeCollectionViewController: UIViewController {
    
    private let usecase: BoxOfficeUseCaseProtocol
    
    init(usecase: BoxOfficeUseCaseProtocol) {
        self.usecase = usecase
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await fetchBoxOfficeData()
        }

    }
    
}



extension BoxOfficeCollectionViewController {
    
    func fetchBoxOfficeData() async {
        let result = await usecase.fetchBoxOfficeData()
        switch result {
        case .success(let data):
            print(data)
        case .failure(let error):
            presentError(error)
        }
    }
    
    func presentError(_ error: DomainError) {
        let message: String
        switch error {
        case .networkIssue:
            message = "Please check your internet connection and try again."
        case .dataUnavailable:
            message = "Requested data is currently unavailable. Please try again later."
        case .unknown:
            message = "An unexpected error occurred. Please try again."
        }
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }


}

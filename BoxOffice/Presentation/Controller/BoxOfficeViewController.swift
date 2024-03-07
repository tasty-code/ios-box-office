
import UIKit

final class BoxOfficeViewController: UIViewController {
    
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
            await fetchDetailMovieData()
        }
    }
}

extension BoxOfficeViewController {
    
    func fetchBoxOfficeData() async {
        let result = await usecase.fetchBoxOfficeData()
        switch result {
        case .success(let data):
            print("일일 박스오피스 조회")
            print(data)
        case .failure(let error):
            presentError(error)
        }
    }
    
    func fetchDetailMovieData() async {
        let result = await usecase.fetchDetailMovieData(movie: "20231010")
        switch result {
        case .success(let data):
            print("영화 개별 상세 조회")
            print(data)
        case .failure(let error):
            presentError(error)
        }
    }
    
    func presentError(_ error: DomainError) {
        let message: String
        switch error {
        case .networkIssue:
            message = error.localizedDescription 
        case .dataUnavailable:
            message = error.localizedDescription
        case .unknown:
            message = error.localizedDescription
        }
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}

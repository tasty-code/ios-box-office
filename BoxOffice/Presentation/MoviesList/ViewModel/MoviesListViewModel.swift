import Foundation

typealias MoviesListViewModel = MoviesListInput & MoviesListOutput

protocol MoviesListInput {
    func viewDidLoad()
    func refresh()
}

protocol MoviesListOutput {
    var movies: Observable<[MoviesCellViewModel]> { get }
    var errorMessage: Observable<String> { get }
    var isRefreshing: Observable<Bool> { get }
}

final class DefaultMoviesListViewModel: MoviesListViewModel {
    private let useCase: BoxOfficeUseCase
    var movies: Observable<[MoviesCellViewModel]> = Observable([])
    var errorMessage: Observable<String> = Observable("")
    var isRefreshing: Observable<Bool> = Observable(false)
    
    init(useCase: BoxOfficeUseCase) {
        self.useCase = useCase
    }
    
    private func fetchData() {
        useCase.fetch { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let boxOffice):
                    self?.movies.value = boxOffice.movieBoxOfficeList.map { .init(movie: $0) }
                case .failure(let error):
                    self?.errorMessage.value = error.localizedDescription
                }
                self?.isRefreshing.value = false
            }
        }
    }
    
    func viewDidLoad() {
        fetchData()
    }
    
    func refresh() {
        isRefreshing.value = true
        fetchData()
    }
}



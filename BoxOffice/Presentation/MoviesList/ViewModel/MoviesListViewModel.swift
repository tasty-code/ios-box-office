import Foundation

final class MoviesListViewModel {
    private let useCase: BoxOfficeUseCase
    var movies: Observable<[MoviesCellViewModel]> = Observable([])
    var errorMessage: Observable<String> = Observable("")
    
    init(useCase: BoxOfficeUseCase) {
        self.useCase = useCase
    }
    
    func fetchData() {
        useCase.fetch { result in
            switch result {
            case .success(let boxOffice):
                self.movies.value = boxOffice.movieBoxOfficeList.map { .init(movie: $0) }
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
}

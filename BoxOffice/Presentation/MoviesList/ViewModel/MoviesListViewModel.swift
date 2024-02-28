import Foundation

class MoviesListViewModel {
    let useCase: BoxOfficeUseCase
    var movies: ObservableValue<[MoviesCellViewModel]> = ObservableValue([])
    
    init(useCase: BoxOfficeUseCase) {
        self.useCase = useCase
    }
    
    func fetchData(completion: @escaping (Result<[MovieBoxOffice], Error>) -> Void) {
        useCase.fetch { result in
            switch result {
            case .success(let boxOffice):
                print(boxOffice.movieBoxOfficeList)
                completion(.success(boxOffice.movieBoxOfficeList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

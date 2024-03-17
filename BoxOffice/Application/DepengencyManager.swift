import Foundation

class DepengencyManager {
    let sessionMananger = DefaultNetworkSessionManager()
    lazy var networkService = DefaultNetworkService(sessionManager: sessionMananger)
    lazy var dataTransferService = DefaultDataTransferService(with: networkService)
    
    func makeMoviesListViewController(navigator: Navigator) -> MoviesListViewController {
        let boxOfficeRepository = DefaultBoxOfficeRepository(dataTransferService: dataTransferService)
        let boxOfficeUseCase = DefaulBoxOfficeUseCase(boxOfficeRepository: boxOfficeRepository)
        let movieListViewModel = MoviesListViewModel(useCase: boxOfficeUseCase)
        return MoviesListViewController(viewModel: movieListViewModel, navigator: navigator)
    }
    
    func makeMovieDetailViewController(navigator: Navigator,  
                                       movieCode: String,
                                       movieName: String) -> MovieDetailViewController {
        let movieDetailRepository = DefaultMovieDetailRepository(dataTransferService: dataTransferService)
        let movieDetailUseCase = DefaultMovieDetailUseCase(movieDetailRepository: movieDetailRepository)
        
        let movieImageRepository = DefaultMovieImageRepository(dataTransferService: dataTransferService)
        let movieImageUseCase = DefaulMovieImageUseCase(movieImageRepository: movieImageRepository)
        
        let movieDetailViewModel = MovieDetailViewModel(detailUseCase: movieDetailUseCase, imageUseCase: movieImageUseCase, movieCode: movieCode, movieName: movieName)
        return MovieDetailViewController(viewModel: movieDetailViewModel, navigator: navigator)
    }
}

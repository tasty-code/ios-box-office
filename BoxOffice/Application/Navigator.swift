import UIKit

protocol NavigatorProtocol {
    func initializeViewController(destination: Navigator.Destination) -> UIViewController
    func navigate(to destination: Navigator.Destination, from viewController: UIViewController)
}

class Navigator: NavigatorProtocol {
    enum Destination {
        case movieList
        case detailMovie(movieCode: String)
    }
    
    func initializeViewController(destination: Destination) -> UIViewController {
        let sessionMananger = DefaultNetworkSessionManager()
        let networkService = DefaultNetworkService(sessionManager: sessionMananger)
        let dataTransferService = DefaultDataTransferService(with: networkService)
        
        switch destination {
        case .movieList:
            let boxOfficeRepository = DefaultBoxOfficeRepository(dataTransferService: dataTransferService)
            let boxOfficeUseCase = DefaulBoxOfficeUseCase(boxOfficeRepository: boxOfficeRepository)
            let movieListViewModel = DefaultMoviesListViewModel(useCase: boxOfficeUseCase)
            let moviesListViewController = MoviesListViewController(viewModel: movieListViewModel, navigator: self)
            let navigationController = UINavigationController(rootViewController: moviesListViewController)
            return navigationController
        case .detailMovie(let movieCode):
            let movieDetailRepository = DefaultMovieDetailRepository(dataTransferService: dataTransferService)
            let movieDetailUseCase = DefaultMovieDetailUseCase(movieDetailRepository: movieDetailRepository)
            
            // 이미지.....떼잉 쯧
            let movieImageRepository = DefaultMovieImageRepository(dataTransferService: dataTransferService)
            let movieImageUseCase = DefaulMovieImageUseCase(movieImageRepository: movieImageRepository)
            let movieDetailViewModel = DefaltMovieDetailViewModel(detailUseCase: movieDetailUseCase, imageUseCase: movieImageUseCase)
            let movieDetailView = MovieDetailView(movieCode: movieCode, viewModel: movieDetailViewModel)
            return movieDetailView
        }
    }
    
    func navigate(to destination: Destination, from viewController: UIViewController) {
        switch destination {
        case .detailMovie(let movieCode):
            guard let detailViewController = initializeViewController(destination: destination) as? MovieDetailView else {
                fatalError("MovieDetailView 에러")
            }
            detailViewController.movieCode = movieCode
            viewController.navigationController?.pushViewController(detailViewController, animated: true)
        default:
            let destinationVC = initializeViewController(destination: destination)
            viewController.navigationController?.setViewControllers([destinationVC], animated: true)
        }
    }
}

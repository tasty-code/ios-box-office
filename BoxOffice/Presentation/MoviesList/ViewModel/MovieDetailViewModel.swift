import UIKit

protocol MovieDetailViewModel {
    var movieDetail: Observable<Movie?> { get }
    var errorMessage: Observable<String> { get }
    var movieImage: Observable<MovieImage?> { get }
    var imageErrorMessage: Observable<String> { get }
    func fetchMovieDetail(movieCode: String)
    func fetchMovieImage(movieName: String)
}

class DefaltMovieDetailViewModel: MovieDetailViewModel {
    var movieImage: Observable<MovieImage?> = Observable(nil)
    var imageErrorMessage: Observable<String> = Observable("")
    var movieDetail: Observable<Movie?> = Observable(nil)
    var errorMessage: Observable<String> = Observable("")
    private let detailUseCase: MovieDetailUseCase
    private let imageUseCase: MovieImageUseCase
    
    init(detailUseCase: MovieDetailUseCase, imageUseCase: MovieImageUseCase) {
        self.detailUseCase = detailUseCase
        self.imageUseCase = imageUseCase
    }
    
    func fetchMovieDetail(movieCode: String) {
        detailUseCase.fetch(movieCode: movieCode) { [weak self] result in
            switch result {
            case .success(let movie):
                DispatchQueue.main.async {
                    self?.movieDetail.value = movie
                    print("\(movie.movieCode)")
                }
            case .failure(let error):
                self?.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func fetchMovieImage(movieName: String) {
        imageUseCase.fetchMovieImage(movieName: movieName) { [weak self] result in
            switch result {
            case .success(let movieImage):
                DispatchQueue.main.async {
                    self?.movieImage.value = movieImage
                    print("\(movieName)")
                }
            case .failure(let error):
                self?.imageErrorMessage.value = error.localizedDescription
            }
        }
    }
}

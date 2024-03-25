//
//  MovieDetailViewModel.swift
//  BoxOffice
//
//  Created by nayeon  on 3/13/24.
//

import Foundation

final class MovieDetailViewModel: ViewModelType {
    
    private let movieUseCase: MovieUseCase
    private let moviePosterUseCase: MoviePosterUseCase
    private var movieDetail: Observable<MovieEntity?> = Observable(nil)
    private var networkError: Observable<Bool> = Observable(false)
    private var moviePoster: Observable<MoviePosterEntity?> = Observable(nil)
    
    init(movieUseCase: MovieUseCase, moviePosterUseCase: MoviePosterUseCase) {
        self.movieUseCase = movieUseCase
        self.moviePosterUseCase = moviePosterUseCase
    }
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let refreshAction: Observable<Void>
        let movieCode: Observable<String>
        let movieName: Observable<String>
    }
    
    struct Output {
        let movieDetail: Observable<MovieEntity?>
        let networkError: Observable<Bool>
        let moviePoster: Observable<MoviePosterEntity?>
    }
    
    func transform(input: Input) -> Output {
        input.viewDidLoad.subscribe { [weak self] in
            self?.fetchMovieDetail(movieCode: input.movieCode.value, movieName: input.movieName.value)
        }
        
        input.refreshAction.subscribe { [weak self] in
            self?.fetchMovieDetail(movieCode: input.movieCode.value, movieName: input.movieName.value)
        }
        
        input.movieCode.subscribe { [weak self] newMovieCode in
            self?.fetchMovieDetail(movieCode: newMovieCode, movieName: input.movieName.value)
        }
        
        return Output(movieDetail: movieDetail, networkError: networkError, moviePoster: moviePoster)
    }
    
    private func fetchMovieDetail(movieCode: String, movieName: String) {
        movieUseCase.fetchMovieDetail(movieCode: movieCode) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.movieDetail.value = data
                }
            default:
                DispatchQueue.main.async {
                    self?.networkError.value = true
                }
            }
        }
        
        moviePosterUseCase.fetchMoviePoster(query: movieName) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.moviePoster.value = data
                }
            default:
                break
            }
        }
    }
}

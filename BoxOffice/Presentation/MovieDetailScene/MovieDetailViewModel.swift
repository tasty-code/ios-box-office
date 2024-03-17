//
//  MovieDetailViewModel.swift
//  BoxOffice
//
//  Created by nayeon  on 3/13/24.
//

import Foundation

final class MovieDetailViewModel: ViewModelType {
    
    private let movieUseCase: MovieUseCase
    private var movieDetail: Observable<MovieEntity?> = Observable(nil)
    private var networkError: Observable<Bool> = Observable(false)
    
    init(movieUseCase: MovieUseCase) {
        self.movieUseCase = movieUseCase
    }
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let refreshAction: Observable<Void>
        let movieCode: Observable<String>
    }
    
    struct Output {
        let movieDetail: Observable<MovieEntity?>
        let networkError: Observable<Bool>
    }
    
    func transform(input: Input) -> Output {
        input.viewDidLoad.subscribe { [weak self] in
            self?.fetchMovieDetail(movieCode: input.movieCode.value)
        }
        
        input.refreshAction.subscribe { [weak self] in
            self?.fetchMovieDetail(movieCode: input.movieCode.value)
        }
        
        input.movieCode.subscribe { [weak self] newMovieCode in
            self?.fetchMovieDetail(movieCode: newMovieCode)
        }
        
        return Output(movieDetail: movieDetail, networkError: networkError)
    }
    
    private func fetchMovieDetail(movieCode: String) {
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
    }
}

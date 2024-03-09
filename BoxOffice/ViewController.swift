//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fatchMovieDatail()
        fetchDailyBoxOffice()
    }
    // 일별 박스오피스 테스트 용
    private func fetchDailyBoxOffice() {
        let date = Date.yesterdayFormatted
        NetworkManager.shared.fetchDailyBoxOffice(for: date ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let boxOfficeMovies):
                    for movie in boxOfficeMovies {
                        print("-----------------------------")
                        print("순위: \(movie.rank)")
                        print("영화 이름: \(movie.movieName)")
                        print("개봉일: \(movie.openDate)")
                        print("관객 수: \(movie.audienceCount)명")
                        print("무비 코드: \(movie.movieCode)")
                        print("-----------------------------")
                    }
                case .failure(let error):
                    print("박스오피스 데이터를 가져오는데 실패 \(error)")
                    
                }
            }
        }
    }
    // 영화 상세정보 테스트 용
    private func fatchMovieDatail() {
        let movieCode = "20236180"
        
        NetworkManager.shared.fetchMovieDetail(for: movieCode) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movieDetail):
                    print("-----------------------------")
                    print("영화 코드: \(movieDetail.movieCode)")
                    print("영화 이름: \(movieDetail.movieName)")
                    print("영화 영문 이름: \(movieDetail.movieNameEnglish)")
                    print("상영 시간: \(movieDetail.runningTime)분")
                    print("제작 연도: \(movieDetail.productionYear)")
                    print("개봉일: \(movieDetail.openDate)")
                    print("영화 타입: \(movieDetail.movieType)")
                    print("장르: \(movieDetail.genres.joined(separator: ", "))")
                    
                    if !movieDetail.directors.isEmpty {
                        print("감독: \(movieDetail.directors.joined(separator: ", "))")
                    } else {
                        print("감독 정보 없음")
                    }
                    
                    print("-----------------------------")
                case .failure(let error):
                    print("영화 상세 정보를 가져오는데 실패했습니다: \(error)")
                }
            }
        }
    }
}

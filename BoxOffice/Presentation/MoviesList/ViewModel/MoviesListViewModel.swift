import Foundation
import UIKit

typealias MoviesListViewModel = MoviesListInput & MoviesListOutput

protocol MoviesListInput {
    func viewDidLoad()
    func refresh()
    func loadCell(_ index: Int)
}

protocol MoviesListOutput {
    var movies: Observable<[MovieBoxOffice]> { get }
    var errorMessage: Observable<String> { get }
    var isRefreshing: Observable<Bool> { get }
    var nowCell: Observable<(String, String, String, UIColor, String)> { get }
}

final class DefaultMoviesListViewModel: MoviesListViewModel {
    private let useCase: BoxOfficeUseCase
    var movies: Observable<[MovieBoxOffice]> = Observable([])
    var errorMessage: Observable<String> = Observable("")
    var isRefreshing: Observable<Bool> = Observable(false)
    var nowCell: Observable<(String, String, String, UIColor, String)> = Observable(("", "", "", .white, ""))
    
    init(useCase: BoxOfficeUseCase) {
        self.useCase = useCase
    }
    
    private func fetchData() {
        useCase.fetch { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let boxOffice):
                    self?.movies.value = boxOffice.movieBoxOfficeList
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
    
    func loadCell(_ index: Int) {
        let movie = movies.value[index]
        var movieName: String {
            var text = movie.movieName
            if text.count > 20 {
                let index = text.index(text.startIndex, offsetBy: 20)
                text = String(text[..<index]) + "..."
                return text
            }
            return text
        }
        
        var rank: String {
            return "\(movie.rank)"
        }
        var rankChangeText: String {
            if movie.rankChangesWithPreviousDay > 0 {
                return "▲\(movie.rankChangesWithPreviousDay)"
            }
            if movie.rankChangesWithPreviousDay < 0 {
                return "▼\(abs(movie.rankChangesWithPreviousDay))"
            }
            if movie.rankOldAndNew == .new {
                return "신작"
            }
            return "-"
        }
        var rankChangeColor: UIColor {
            if movie.rankOldAndNew == .new {
                return .red
            }
            if movie.rankChangesWithPreviousDay > 0 {
                return .red
            }
            if movie.rankChangesWithPreviousDay < 0 {
                return .blue
            }
            return .gray
        }
        var audienceText: String {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            let formattedAudienceCount = formatter.string(from: NSNumber(value: movie.audienceCount)) ?? "\(movie.audienceCount)"
            let formattedAccumulation = formatter.string(from: NSNumber(value: movie.audienceAccumulation)) ?? "\(movie.audienceAccumulation)"
            return "오늘 \(formattedAudienceCount) / 총 \(formattedAccumulation)"
        }
        let cellInformation = (movieName, rank, rankChangeText, rankChangeColor, audienceText)
        nowCell.value = cellInformation
    }
    
}

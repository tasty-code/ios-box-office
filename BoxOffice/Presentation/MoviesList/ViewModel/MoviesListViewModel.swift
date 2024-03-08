import UIKit

typealias MoviesListViewModel = MoviesListInput & MoviesListOutput

protocol MoviesListInput {
    func viewDidLoad()
    func refresh()
    func loadCell(_ index: Int)
    func fetchMovieDetail(movieCode: String)
}

protocol MoviesListOutput {
    var movies: Observable<[MovieBoxOffice]> { get }
    var movieDetail: Observable<Movie?> { get }
    var errorMessage: Observable<String> { get }
    var isRefreshing: Observable<Bool> { get }
    var nowCellInformation: Observable<(String, String, String, UIColor, String)> { get }
}

final class DefaultMoviesListViewModel: MoviesListViewModel {
    var movieDetail: Observable<Movie?> = Observable(nil)
    private let detailUseCase: MovieDetailUseCase
    private let useCase: BoxOfficeUseCase
    var movies: Observable<[MovieBoxOffice]> = Observable([])
    var errorMessage: Observable<String> = Observable("")
    var isRefreshing: Observable<Bool> = Observable(false)
    var nowCellInformation: Observable<(String, String, String, UIColor, String)> = Observable(("", "", "", .white, ""))
    
    init(useCase: BoxOfficeUseCase, movieUseCase: MovieDetailUseCase) {
        self.useCase = useCase
        self.detailUseCase = movieUseCase
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
        nowCellInformation.value = cellInformation
    }
    
    func fetchMovieDetail(movieCode: String) {
        detailUseCase.fetch(movieCode: movieCode) { [weak self] result in
            switch result {
            case .success(let movie):
                DispatchQueue.main.async {
                    self?.movieDetail.value = movie
                    print("\(movieCode)")
                }
            case .failure(let error):
                self?.errorMessage.value = error.localizedDescription
            }
        }
    }
}

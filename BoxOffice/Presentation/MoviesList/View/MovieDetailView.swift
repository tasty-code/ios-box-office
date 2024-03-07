import UIKit

final class MovieDetailView: UIViewController {

    private let movieName: String
    
    init(movie: MovieBoxOffice) {
        self.movieName = movie.movieName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = movieName
    }
}

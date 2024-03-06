import UIKit

final class MovieDetailView: UIViewController {

    private let movie: MovieBoxOffice
    
    init(movie: MovieBoxOffice) {
        self.movie = movie
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
    
    func setupNavigationBar() {
        navigationItem.title = "\(movie.movieName)"
    }
}

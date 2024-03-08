import UIKit

final class MovieDetailView: UIViewController {
    
    private let movie: Movie
    
    // MARK: UIImageView
    private let movieImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: UIScrollView
    private let scrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    // MARK: UIStackView
    private let stackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private let directorStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let productionYearStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let openingDateStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let durationStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let ratingStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let nationsStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let genresStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let actorsStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    // MARK: UILabel
    private let directorTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "감독"
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let directorsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    private let productionYearTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "제작년도"
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let productionYearLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    private let openingDateTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "개봉일"
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let openingDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    private let durationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "상영시간"
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    private let ratingTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "관람등급"
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    private let nationsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "제작국가"
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let nationsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    private let genresTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "장르"
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let genresLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    private let actorsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "배우"
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let actorsLabel: UILabel = {
        let textView = UILabel()
        textView.font = .systemFont(ofSize: 15)
        textView.textColor = .black
        textView.numberOfLines = 10
        return textView
    }()
    
    init(movie: Movie) {
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
        setupViews()
        configureLabels(with: movie)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = movie.movieName
    }
}

// MARK: setupViews
extension MovieDetailView {
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(movieImageView)
        stackView.addArrangedSubview(directorStackView)
        stackView.addArrangedSubview(productionYearStackView)
        stackView.addArrangedSubview(openingDateStackView)
        stackView.addArrangedSubview(durationStackView)
        stackView.addArrangedSubview(ratingStackView)
        stackView.addArrangedSubview(nationsStackView)
        stackView.addArrangedSubview(genresStackView)
        stackView.addArrangedSubview(actorsStackView)
        
        directorStackView.addArrangedSubview(directorTitleLabel)
        directorStackView.addArrangedSubview(directorsLabel)
        
        productionYearStackView.addArrangedSubview(productionYearTitleLabel)
        productionYearStackView.addArrangedSubview(productionYearLabel)
        
        openingDateStackView.addArrangedSubview(openingDateTitleLabel)
        openingDateStackView.addArrangedSubview(openingDateLabel)
        
        durationStackView.addArrangedSubview(durationTitleLabel)
        durationStackView.addArrangedSubview(durationLabel)
        
        ratingStackView.addArrangedSubview(ratingTitleLabel)
        ratingStackView.addArrangedSubview(ratingLabel)
        
        nationsStackView.addArrangedSubview(nationsTitleLabel)
        nationsStackView.addArrangedSubview(nationsLabel)
        
        genresStackView.addArrangedSubview(genresTitleLabel)
        genresStackView.addArrangedSubview(genresLabel)
        
        actorsStackView.addArrangedSubview(actorsTitleLabel)
        actorsStackView.addArrangedSubview(actorsLabel)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -10),
            stackView.widthAnchor.constraint(equalToConstant: 400),
            
            movieImageView.widthAnchor.constraint(equalToConstant: 420),
            movieImageView.heightAnchor.constraint(equalToConstant: 300),
            directorTitleLabel.widthAnchor.constraint(equalToConstant: 60),
            productionYearTitleLabel.widthAnchor.constraint(equalToConstant: 60),
            openingDateTitleLabel.widthAnchor.constraint(equalToConstant: 60),
            durationTitleLabel.widthAnchor.constraint(equalToConstant: 60),
            ratingTitleLabel.widthAnchor.constraint(equalToConstant: 60),
            nationsTitleLabel.widthAnchor.constraint(equalToConstant: 60),
            genresTitleLabel.widthAnchor.constraint(equalToConstant: 60),
            actorsTitleLabel.widthAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    private func configureLabels(with movieDetail: Movie) {
        //   movieImageView.image = UIImage(data: <#T##Data#>)
        directorsLabel.text = "\(movieDetail.directors.map { $0.name }.joined(separator: ", "))"
        productionYearLabel.text = "\(movieDetail.productionYear)"
        openingDateLabel.text = Date().openingDayString(with: movieDetail.openingDate, with: DateFormatter.yyMMddDashed)
        durationLabel.text = "\(movieDetail.duration)분"
        ratingLabel.text = "\(movieDetail.audits.first?.rating ?? "-")"
        nationsLabel.text = "\(movieDetail.nations.map { $0.name }.joined(separator: ", "))"
        genresLabel.text = "\(movieDetail.genres.map { $0.name }.joined(separator: ", "))"
        if movieDetail.actors.isEmpty {
            actorsLabel.text = "-"
        } else {
            actorsLabel.text = "\(movieDetail.actors.map { "\($0.name)" }.joined(separator: ", "))"
        }
    }
}

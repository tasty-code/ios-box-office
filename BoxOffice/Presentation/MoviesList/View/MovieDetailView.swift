import UIKit

final class MovieDetailView: UIViewController {
    
    var movieCode: String
    var movieName: String
    private var detailViewModel: MovieDetailViewModel
    
    init(movieCode: String, movieName: String, viewModel: MovieDetailViewModel) {
        self.movieCode = movieCode
        self.movieName = movieName
        self.detailViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        detailViewModel.fetchMovieDetail(movieCode: movieCode)
        detailViewModel.fetchMovieImage(movieName: movieName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIActivityIndicatorView
    private lazy var indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = UIColor.gray
        indicator.startAnimating()
        return indicator
    }()
    
    // MARK: UIScrollView
    private let scrollView =  UIScrollView()
    
    // MARK: UIImageView
    private let movieImageView = UIImageView()
    
    // MARK: UIStackView
    private lazy var totalStackView = makeStack(axis: .vertical, alignment: .leading)
    private lazy var directorStackView = makeStack(axis: .horizontal, alignment: .center)
    private lazy var productionYearStackView = makeStack(axis: .horizontal, alignment: .center)
    private lazy var openingDateStackView = makeStack(axis: .horizontal, alignment: .center)
    private lazy var durationStackView = makeStack(axis: .horizontal, alignment: .center)
    private lazy var ratingStackView = makeStack(axis: .horizontal, alignment: .center)
    private lazy var nationsStackView = makeStack(axis: .horizontal, alignment: .center)
    private lazy var genresStackView = makeStack(axis: .horizontal, alignment: .center)
    private lazy var actorsStackView = makeStack(axis: .horizontal, alignment: .center)
    
    // MARK: UILabel
    private lazy var directorTitleLabel = makeLabel(text: "감독", textAlignment: .center, bold: true)
    private lazy var directorsLabel = makeLabel(textAlignment: .left, bold: false)
    private lazy var productionYearTitleLabel = makeLabel(text: "제작년도", textAlignment: .center, bold: true)
    private lazy var productionYearLabel = makeLabel(textAlignment: .left, bold: false)
    private lazy var openingDateTitleLabel = makeLabel(text: "개봉일", textAlignment: .center, bold: true)
    private lazy var openingDateLabel = makeLabel(textAlignment: .center, bold: false)
    private lazy var durationTitleLabel = makeLabel(text: "상영시간", textAlignment: .center, bold: true)
    private lazy var durationLabel = makeLabel(textAlignment: .left, bold: false)
    private lazy var ratingTitleLabel = makeLabel(text: "관람등급", textAlignment: .center, bold: true)
    private lazy var ratingLabel = makeLabel( textAlignment: .left, bold: false)
    private lazy var nationsTitleLabel = makeLabel(text: "제작국가", textAlignment: .center, bold: true)
    private lazy var nationsLabel = makeLabel(textAlignment: .left, bold: false)
    private lazy var genresTitleLabel = makeLabel(text: "장르", textAlignment: .center, bold: true)
    private lazy var genresLabel = makeLabel(textAlignment: .left, bold: false)
    private lazy var actorsTitleLabel = makeLabel(text: "배우", textAlignment: .center, bold: true)
    private lazy var actorsLabel = makeLabel(textAlignment: .left, bold: false, numberOfLines: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviewsAndSetupLayout()
        setupLayoutViews()
        bind()
    }
}

// MARK: Binding
extension MovieDetailView {
    private func bind() {
        detailViewModel.movieDetail.bind{ [weak self] movie in
            guard let movie = movie else { return }
            self?.configureLabels(with: movie)
        }
        detailViewModel.errorMessage.bind{ [weak self] errorMessage in
            self?.makeAlert(message: errorMessage, confirmAction: nil)
        }
        detailViewModel.movieImage.bind { [weak self] movieImage in
            guard let movieImage = movieImage else { return }
            self?.configureImageView(with: movieImage)
        }
    }
    
    private func configureLabels(with movie: Movie) {
        navigationItem.title = movie.movieName
        directorsLabel.text = "\(movie.directors.map { $0.name }.joined(separator: ", "))"
        productionYearLabel.text = "\(movie.productionYear)"
        openingDateLabel.text = "\(Date().openingDayString(day: movie.openingDate, format: DateFormatter.yyMMddDashed))"
        durationLabel.text = "\(movie.duration)분"
        ratingLabel.text = "\(movie.audits.first?.rating ?? "-")"
        nationsLabel.text = "\(movie.nations.map { $0.name }.joined(separator: ", "))"
        genresLabel.text = "\(movie.genres.map { $0.name }.joined(separator: ", "))"
        actorsLabel.text = "\(movie.actors.isEmpty ? "-" : movie.actors.map { $0.name }.joined(separator: ", "))"
    }
    
    private func configureImageView(with movieImage: MovieImage) {
        guard let imageURLString = movieImage.documents.first?.imageURL,
              let imageURL = URL(string: imageURLString) else {
            print("URL error")
            return
        }
        DispatchQueue.global().async { [weak self] in
            do {
                let imageData = try Data(contentsOf: imageURL)
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    self?.indicatorView.stopAnimating()
                    self?.indicatorView.removeFromSuperview()
                    self?.movieImageView.image = image
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: Custom
extension MovieDetailView {
    private func makeStack(axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }
    
    private func makeLabel(text: String? = nil, textAlignment: NSTextAlignment, bold: Bool, numberOfLines: Int? = nil) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = bold ? .boldSystemFont(ofSize: 15) : .systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = textAlignment
        if let numberOfLines = numberOfLines {
            label.numberOfLines = numberOfLines
        }
        return label
    }
}

// MARK: Layout
extension MovieDetailView {
    private func addSubviewsAndSetupLayout() {
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(totalStackView)
        totalStackView.addArrangedSubview(movieImageView)
        totalStackView.addArrangedSubview(directorStackView)
        totalStackView.addArrangedSubview(productionYearStackView)
        totalStackView.addArrangedSubview(openingDateStackView)
        totalStackView.addArrangedSubview(durationStackView)
        totalStackView.addArrangedSubview(ratingStackView)
        totalStackView.addArrangedSubview(nationsStackView)
        totalStackView.addArrangedSubview(genresStackView)
        totalStackView.addArrangedSubview(actorsStackView)
        
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
        movieImageView.addSubview(indicatorView)
    }
    private func setupLayoutViews() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            totalStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 10),
            totalStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 10),
            totalStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -10),
            totalStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -10),
            totalStackView.widthAnchor.constraint(equalToConstant: 410),
            
            movieImageView.widthAnchor.constraint(equalToConstant: 410),
            movieImageView.heightAnchor.constraint(equalToConstant: 500),
            
            indicatorView.centerXAnchor.constraint(equalTo: movieImageView.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: movieImageView.centerYAnchor),
            
            directorTitleLabel.widthAnchor.constraint(equalToConstant: 60),
            productionYearTitleLabel.widthAnchor.constraint(equalToConstant: 60),
            openingDateTitleLabel.widthAnchor.constraint(equalToConstant: 60),
            durationTitleLabel.widthAnchor.constraint(equalToConstant: 60),
            ratingTitleLabel.widthAnchor.constraint(equalToConstant: 60),
            nationsTitleLabel.widthAnchor.constraint(equalToConstant: 60),
            genresTitleLabel.widthAnchor.constraint(equalToConstant: 60),
            actorsTitleLabel.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}

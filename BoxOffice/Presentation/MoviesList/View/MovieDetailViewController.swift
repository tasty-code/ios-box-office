import UIKit

final class MovieDetailViewController: UIViewController {
    private var viewModel: MovieDetailViewModel
    private var callMovieDetailEvent: Observable<Void> = Observable(())
    private var callMovieImageEvent: Observable<Void> = Observable(())
    
    private lazy var input = MovieDetailViewModel.Input(callMovieDetailEvent: callMovieDetailEvent,
                                                        callMovieImageEvent: callMovieImageEvent)
    private lazy var output = viewModel.transform(input: input)
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
    private let totalStackView = UIStackView().makeStackView(axis: .vertical, alignment: .leading, spacing: 8)
    private let directorStackView = UIStackView().makeStackView(axis: .horizontal, alignment: .center, spacing: 8)
    private let productionYearStackView = UIStackView().makeStackView(axis: .horizontal, alignment: .center, spacing: 8)
    private let openingDateStackView = UIStackView().makeStackView(axis: .horizontal, alignment: .center, spacing: 8)
    private let durationStackView = UIStackView().makeStackView(axis: .horizontal, alignment: .center, spacing: 8)
    private let ratingStackView = UIStackView().makeStackView(axis: .horizontal, alignment: .center, spacing: 8)
    private let nationsStackView = UIStackView().makeStackView(axis: .horizontal, alignment: .center, spacing: 8)
    private let genresStackView = UIStackView().makeStackView(axis: .horizontal, alignment: .center, spacing: 8)
    private let actorsStackView = UIStackView().makeStackView(axis: .horizontal, alignment: .center, spacing: 8)
    
    // MARK: UILabel
    private let directorTitleLabel = UILabel().makeDetailLabel(text: "감독", textAlignment: .center, bold: true)
    private let directorsLabel = UILabel().makeDetailLabel(textAlignment: .left, bold: false)
    private let productionYearTitleLabel = UILabel().makeDetailLabel(text: "제작년도", textAlignment: .center, bold: true)
    private let productionYearLabel = UILabel().makeDetailLabel(textAlignment: .left, bold: false)
    private let openingDateTitleLabel = UILabel().makeDetailLabel(text: "개봉일", textAlignment: .center, bold: true)
    private let openingDateLabel = UILabel().makeDetailLabel(textAlignment: .center, bold: false)
    private let durationTitleLabel = UILabel().makeDetailLabel(text: "상영시간", textAlignment: .center, bold: true)
    private let durationLabel = UILabel().makeDetailLabel(textAlignment: .left, bold: false)
    private let ratingTitleLabel = UILabel().makeDetailLabel(text: "관람등급", textAlignment: .center, bold: true)
    private let ratingLabel = UILabel().makeDetailLabel( textAlignment: .left, bold: false)
    private let nationsTitleLabel = UILabel().makeDetailLabel(text: "제작국가", textAlignment: .center, bold: true)
    private let nationsLabel = UILabel().makeDetailLabel(textAlignment: .left, bold: false)
    private let genresTitleLabel = UILabel().makeDetailLabel(text: "장르", textAlignment: .center, bold: true)
    private let genresLabel = UILabel().makeDetailLabel(textAlignment: .left, bold: false)
    private let actorsTitleLabel = UILabel().makeDetailLabel(text: "배우", textAlignment: .center, bold: true)
    private let actorsLabel = UILabel().makeDetailLabel(textAlignment: .left, bold: false, numberOfLines: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviewsAndSetupLayout()
        setupLayoutViews()
        bind()
        callMovieData()
    }
}

// MARK: Binding
extension MovieDetailViewController {
    private func callMovieData() {
        input.callMovieDetailEvent.value = ()
        input.callMovieImageEvent.value = ()
    }
    
    private func bind() {
        output.movieDetail.bind{ [weak self] movie in
            guard let movie = movie else { return }
            self?.configureLabels(with: movie)
        }
        output.errorMessage.bind{ [weak self] errorMessage in
            self?.makeAlert(message: errorMessage, confirmAction: nil)
        }
        output.movieImage.bind { [weak self] movieImage in
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

// MARK: Layout
extension MovieDetailViewController {
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
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            totalStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            totalStackView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 10),
            totalStackView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -10),
            totalStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            movieImageView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -20),
            movieImageView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, multiplier: 1.5),
            
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

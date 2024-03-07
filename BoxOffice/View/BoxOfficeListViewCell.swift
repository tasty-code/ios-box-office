import UIKit

final class BoxOfficeListViewCell: UICollectionViewListCell {
    static let reuseIdentifier = String(describing: BoxOfficeListViewCell.self)
    private let oldAndNewStackView = OldAndNewStackView()
    private let movieStackView = MovieStackView()
    private lazy var mainStackOfMovieListCollectionViewCell: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [oldAndNewStackView, movieStackView])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 0
        stack.alignment = .center
        return stack
    }()
    
    private let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        setupConstraints()
        setupSeparatorLine()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BoxOfficeListViewCell {
   private func configureViews() {
        contentView.addSubview(mainStackOfMovieListCollectionViewCell)
    }
    
    private func setupConstraints() {
        oldAndNewStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2).isActive = true
        mainStackOfMovieListCollectionViewCell.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackOfMovieListCollectionViewCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            mainStackOfMovieListCollectionViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainStackOfMovieListCollectionViewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            mainStackOfMovieListCollectionViewCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    private func setupSeparatorLine() {
        addSubview(separatorLine)
        NSLayoutConstraint.activate([
            separatorLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorLine.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}

extension BoxOfficeListViewCell {
    func configure(with result: CustomDailyBoxOffice) {
        oldAndNewStackView.configure(rank: result.rank,
                                     rankOldAndNew: result.rankOldAndNew.rawValue,
                                     rankChanged: result.rankChange)
        
        movieStackView.configureMovieStackView(todayAdience: result.todayAudience,
                                               movieName: result.movieName,
                                               totalAdience: result.totalAudience)
    }
}

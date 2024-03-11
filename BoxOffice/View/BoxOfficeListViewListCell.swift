import UIKit

final class BoxOfficeListViewListCell: UICollectionViewListCell {
    static let reuseIdentifier = String(describing: BoxOfficeListViewListCell.self)
    private let oldAndNewStackView = OldAndNewStackView()
    private let movieStackView = MovieStackView()
    private lazy var mainStackOfMovieListCollectionViewCellStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [oldAndNewStackView, movieStackView])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 0
        stack.alignment = .center
        return stack
    }()
    
    private let separatorLineView: UIView = {
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

extension BoxOfficeListViewListCell {
   private func configureViews() {
        contentView.addSubview(mainStackOfMovieListCollectionViewCellStackView)
    }
    
    private func setupConstraints() {
        oldAndNewStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2).isActive = true
        mainStackOfMovieListCollectionViewCellStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackOfMovieListCollectionViewCellStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            mainStackOfMovieListCollectionViewCellStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainStackOfMovieListCollectionViewCellStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            mainStackOfMovieListCollectionViewCellStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    private func setupSeparatorLine() {
        addSubview(separatorLineView)
        NSLayoutConstraint.activate([
            separatorLineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorLineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorLineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}

extension BoxOfficeListViewListCell {
    func configure(with result: CustomDailyBoxOffice) {
        oldAndNewStackView.configure(rank: result.rank,
                                     rankOldAndNew: result.rankOldAndNew.rawValue,
                                     rankChanged: result.rankChange)
        
        movieStackView.configureMovieStackView(todayAdience: result.todayAudience,
                                               movieName: result.movieName,
                                               totalAdience: result.totalAudience)
    }
}

import UIKit

final class BoxOfficeCollectionViewCell: UICollectionViewCell {
  //  private var boxOfficeListItem: DailyBoxOffice.ListItem?
  
  private var rankLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .title1)
    label.textAlignment = .center
    return label
  }()
  
  private let riseOrFallView = RiseOrFallStackView()
  
  private lazy var rankInfoStackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [
      rankLabel, riseOrFallView
    ])
    stack.axis = .vertical
    stack.spacing = 0
    return stack
  }()
  
  private let movieNameLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .subheadline)
    return label
  }()
  
  private let audienceLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .subheadline)
    return label
  }()
  
  private lazy var movieInfoStackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [
      movieNameLabel, audienceLabel
    ])
    stack.axis = .vertical
    stack.spacing = 1
    return stack
  }()
  
  private let chevron: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "chevron.right")
    imageView.tintColor = .lightGray
    return imageView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setLayout()
  }
  
  init() {
    super.init(frame: .zero)
    setLayout()
  }
  
  @available(*, unavailable)
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setLayout() {
    self.rankInfoStackView.translatesAutoresizingMaskIntoConstraints = false
    self.movieInfoStackView.translatesAutoresizingMaskIntoConstraints = false
    self.chevron.translatesAutoresizingMaskIntoConstraints = false
    
    self.contentView.addSubview(self.rankInfoStackView)
    self.contentView.addSubview(self.movieInfoStackView)
    self.contentView.addSubview(self.chevron)
    
    NSLayoutConstraint.activate(
      [
        self.rankInfoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//        self.rankInfoStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        self.rankInfoStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
        self.rankInfoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
        self.rankInfoStackView.heightAnchor.constraint(equalToConstant: 60),
        self.movieInfoStackView.leadingAnchor.constraint(equalTo: rankInfoStackView.trailingAnchor, constant: 15),
        self.movieInfoStackView.centerYAnchor.constraint(equalTo: rankInfoStackView.centerYAnchor),
        self.chevron.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        self.chevron.centerYAnchor.constraint(equalTo: rankInfoStackView.centerYAnchor),
        self.chevron.leadingAnchor.constraint(greaterThanOrEqualTo: movieInfoStackView.trailingAnchor, constant: 0),
      ]
    )
  }
  
  func configure(with item: DailyBoxOffice.ListItem) {
    self.rankLabel.text = String(item.rank)
    
    let movieStatus = MovieStatus.init(
      entryStatus: item.entryStatus,
      rankChange: item.rankChange
    )
    self.riseOrFallView.configure(with: movieStatus)
    
    self.movieNameLabel.text = item.title
    self.audienceLabel.text = "오늘 \(item.todayAudienceCount) / 총 \(item.totalAudienceCount)"
  }
}

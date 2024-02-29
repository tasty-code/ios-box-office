import UIKit

final class BoxOfficeCollectionViewCell: UICollectionViewCell {
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
    
    NSLayoutConstraint.activate([
      self.movieInfoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 70),
      self.movieInfoStackView.centerYAnchor.constraint(equalTo: rankInfoStackView.centerYAnchor),
      self.rankInfoStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
      self.rankInfoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
      self.rankInfoStackView.heightAnchor.constraint(equalToConstant: 55),
      self.rankInfoStackView.centerXAnchor.constraint(equalTo: self.movieInfoStackView.leadingAnchor, constant: -32),
      self.chevron.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      self.chevron.centerYAnchor.constraint(equalTo: rankInfoStackView.centerYAnchor),
      self.chevron.leadingAnchor.constraint(greaterThanOrEqualTo: movieInfoStackView.trailingAnchor, constant: 10),
    ])
  }
  
  func configure(with item: DailyBoxOffice.ListItem) {
    self.rankLabel.text = String(item.rank)
    
    let movieStatus = MovieStatus.init(
      entryStatus: item.entryStatus,
      rankChange: item.rankChange
    )
    self.riseOrFallView.configure(with: movieStatus)
    
    self.movieNameLabel.text = item.title
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    guard
      let today = formatter.string(from: NSNumber(value: item.todayAudienceCount)),
      let total = formatter.string(from: NSNumber(value: item.totalAudienceCount))
    else {
      return
    }
    self.audienceLabel.text = "오늘 \(today) / 총 \(total)"
  }
}

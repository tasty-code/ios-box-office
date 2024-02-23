import UIKit

final class BoxOfficeCollectionViewCell: UICollectionViewCell {
  private var boxOfficeListItem: DailyBoxOfficeResponse.DailyBoxOfficeItem?
  
  private var rankLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .headline)
    return label
  }()
  
  private let riseOrFallView = RiseOrFallStackView()
  
  private lazy var rankInfoStackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [
      rankLabel, riseOrFallView
    ])
    stack.axis = .vertical
    stack.spacing = 2
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
    stack.axis = .horizontal
    stack.spacing = 1
    return stack
  }()
  
  private let chevron: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "chevron.right")
    imageView.tintColor = .lightGray
    return imageView
  }()
  
  private func setLayout() {
    self.contentView.addSubview(rankInfoStackView)
    self.contentView.addSubview(movieInfoStackView)
    self.contentView.addSubview(chevron)
    
    self.rankInfoStackView.translatesAutoresizingMaskIntoConstraints = false
    self.movieInfoStackView.translatesAutoresizingMaskIntoConstraints = false
    self.chevron.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      rankInfoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      rankInfoStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      movieInfoStackView.leadingAnchor.constraint(equalTo: rankInfoStackView.trailingAnchor, constant: 15),
      movieInfoStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      chevron.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      chevron.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      chevron.leadingAnchor.constraint(greaterThanOrEqualTo: movieInfoStackView.trailingAnchor, constant: 0)
      
    ])
  }
  
  func configure(with item: DailyBoxOfficeResponse.DailyBoxOfficeItem) {
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
  

final class RiseOrFallStackView: UIStackView {
  private let riseImage = UIImage(systemName: "arrowtriangle.down.fill")
  private let fallImage = UIImage(systemName: "arrowtriangle.up.fill")
  private let minusImage = UIImage(systemName: "minus")
  
  private let riseOrFallImageView = UIImageView()
  private let riseOrFallLabel = UILabel()
  
  init() {
    super.init(frame: .zero)
    setSubViews()
    setLayout()
  }
  
  @available(*, unavailable)
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setSubViews() {
    self.addArrangedSubview(riseOrFallImageView)
    self.addArrangedSubview(riseOrFallLabel)
  }

  private func setLayout() {
    self.riseOrFallImageView.translatesAutoresizingMaskIntoConstraints = false
    self.riseOrFallLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate(
      [
        riseOrFallImageView.heightAnchor.constraint(equalToConstant: 10),
        riseOrFallLabel.heightAnchor.constraint(equalTo: riseOrFallImageView.heightAnchor)
      ]
    )
  }
  
  func configure(with movieStatus: MovieStatus) {
    switch movieStatus {
    case .newMovie:
      riseOrFallImageView.image = nil
      riseOrFallLabel.text = "신작"
      riseOrFallLabel.textColor = .systemPink
    case let .oldMovie(.risen(number)):
      riseOrFallImageView.image = riseImage
      riseOrFallLabel.text = String(number)
    case let .oldMovie(.fallen(number)):
      riseOrFallImageView.image = fallImage
      riseOrFallLabel.text = String(number)
    case .oldMovie(.maintained):
      riseOrFallImageView.image = minusImage
      riseOrFallLabel.text = ""
    }
  }
}

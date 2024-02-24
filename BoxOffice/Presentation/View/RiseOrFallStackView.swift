import UIKit

final class RiseOrFallStackView: UIStackView {
  private let riseImage = UIImage(systemName: "arrowtriangle.down.fill")
  private let fallImage = UIImage(systemName: "arrowtriangle.up.fill")
  private let minusImage = UIImage(systemName: "minus")
  
  private let riseOrFallImageView = UIImageView()
  private let riseOrFallLabel = UILabel()
  
  init() {
    super.init(frame: .zero)
    setLayout()
  }
  
  @available(*, unavailable)
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setLayout() {
    self.riseOrFallImageView.translatesAutoresizingMaskIntoConstraints = false
    self.riseOrFallLabel.translatesAutoresizingMaskIntoConstraints = false
    
    self.addArrangedSubview(riseOrFallImageView)
    self.addArrangedSubview(riseOrFallLabel)
    
    NSLayoutConstraint.activate(
      [
        self.riseOrFallImageView.heightAnchor.constraint(equalToConstant: 10),
        self.riseOrFallLabel.heightAnchor.constraint(equalTo: riseOrFallImageView.heightAnchor),
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

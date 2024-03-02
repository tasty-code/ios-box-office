import UIKit

final class RiseOrFallStackView: UIStackView {
  private let riseOrFallImageView = UIImageView()
  private let riseOrFallLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .footnote)
    label.textAlignment = .center
    return label
  }()
  
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
        self.riseOrFallImageView.heightAnchor.constraint(equalTo: self.riseOrFallLabel.heightAnchor)
      ]
    )
    self.alignment = .center
  }
  
  func configure(with movieStatus: MovieStatus) {
    if let imageName = movieStatus.imageName {
      self.riseOrFallImageView.isHidden = false
      self.riseOrFallImageView.image = UIImage(systemName: imageName)
    } else {
      self.riseOrFallImageView.isHidden = true
    }
    self.riseOrFallLabel.text = movieStatus.text
  }
}

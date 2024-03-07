import UIKit

class RankStackView: UIStackView {
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    private let oldRankLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 10)
        label.textAlignment = .center
        return label
    }()
    
    private let rankUpImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrowtriangle.up.fill")
        imageView.tintColor = .red
        return imageView
    }()
    
    private let rankDownImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrowtriangle.down.fill")
        imageView.tintColor = .blue
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupRankStackView()
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RankStackView {
    private func setupRankStackView() {
        self.axis = .horizontal
        self.spacing = 0
        self.distribution = .fillEqually
        self.alignment = .center
    }
    
    private func configureRankUpStackView(rank: String) {
        self.addArrangedSubview(rankUpImage)
        self.addArrangedSubview(rankLabel)
        self.rankLabel.text = rank
        rankUpImage.translatesAutoresizingMaskIntoConstraints = false
        rankUpImage.heightAnchor.constraint(equalTo: rankLabel.heightAnchor).isActive = true

    }
    
    private func configureRankDownStackView(rank: String) {
        addArrangedSubview(rankDownImage)
        addArrangedSubview(rankLabel)
        self.rankLabel.text = rank
        rankDownImage.translatesAutoresizingMaskIntoConstraints = false
        rankDownImage.heightAnchor.constraint(equalTo: rankLabel.heightAnchor).isActive = true
    }
    
    private func configureRankNotChangeStackView() {
        self.rankLabel.text = "-"
        self.addArrangedSubview(rankLabel)
    }
}

extension RankStackView {
    func configurePresentRank(rankChange: String) {
        arrangedSubviews.forEach { $0.removeFromSuperview() }
        if rankChange == "0" {
            configureRankNotChangeStackView()
        } else {
            let changeValue = Int(rankChange) ?? 0
            if changeValue > 0 {
                configureRankUpStackView(rank: rankChange)
            } else if changeValue < 0 {
                configureRankDownStackView(rank: rankChange)
            }
        }
    }
}

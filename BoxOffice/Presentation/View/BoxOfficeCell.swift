
import UIKit

final class BoxOfficeCell: UICollectionViewListCell {

    let rankIntensityLabel = UILabel()
    let audienceAccountLabel = UILabel()
    
    let rankLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30.0)
        return label
    }()

    let movieNameLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let horizontalStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.alignment = .center
            stackView.distribution = .fill
            stackView.spacing = 8
            return stackView
    }()
    
    let leftStackView: UIStackView = {
        let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.alignment = .center
            stackView.distribution = .fill
            stackView.spacing = 0
            return stackView
    }()
    
    private let rightStackView: UIStackView = {
        let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.alignment = .leading
            stackView.distribution = .fillEqually
            stackView.spacing = 0
            return stackView
    }()
    
    private let separatorView = UIView()
    var showsSeparator = true {
        didSet {
            updateSeparator()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension BoxOfficeCell {
    
    func configureLayout() {
        configureLabels()
        configureStackViews()
        configureHorizontalStackView()
        configureSeparatorView()
    }
    

    private func configureLabels() {
        [rankLabel, rankIntensityLabel, movieNameLabel, audienceAccountLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.adjustsFontForContentSizeCategory = true
        }
    }

    private func configureStackViews() {
        [leftStackView, rightStackView, horizontalStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.spacing = 0
        }
        
        leftStackView.addArrangedSubview(rankLabel)
        leftStackView.addArrangedSubview(rankIntensityLabel)
        rightStackView.addArrangedSubview(movieNameLabel)
        rightStackView.addArrangedSubview(audienceAccountLabel)
        horizontalStackView.addArrangedSubview(leftStackView)
        horizontalStackView.addArrangedSubview(rightStackView)
        addSubview(horizontalStackView)
    }

    private func configureHorizontalStackView() {

        NSLayoutConstraint.activate([
            horizontalStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            horizontalStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            horizontalStackView.widthAnchor.constraint(equalTo: widthAnchor),
            horizontalStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7)
        ])

        let leftStackWidthConstraint = leftStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2)
        leftStackWidthConstraint.priority = .defaultHigh
        leftStackWidthConstraint.isActive = true
    }

    private func configureSeparatorView() {
        addSubview(separatorView)

        separatorView.backgroundColor = .opaqueSeparator
        separatorView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            separatorView.heightAnchor.constraint(equalToConstant: 0.3),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.topAnchor.constraint(equalTo: topAnchor),
        ])
    }
    
     func test(new: Bool, num: Int) {
            if new {
                rankIntensityLabel.textColor = .red
                rankIntensityLabel.text = "신작"
                return
            }

            switch num {
            case let x where x > 0:
                movieRank(number: num, image: "arrowtriangle.up.fill", color: .red)
            case let x where x < 0:
                movieRank(number: num, image: "arrowtriangle.down.fill", color: .blue)
            default:
                rankIntensityLabel.text = "-"
            }
        }

        func movieRank(number: Int, image: String, color: UIColor) {
            let imageAttachement = NSTextAttachment()
            imageAttachement.image = UIImage(systemName: image)?.withTintColor(color, renderingMode: .alwaysTemplate)
            let attributedString = NSMutableAttributedString(attachment: imageAttachement)
            attributedString.append(NSAttributedString(string: String(abs(number))))
            rankIntensityLabel.attributedText = attributedString
        }

    func updateSeparator() {
        separatorView.isHidden = !showsSeparator
    }
    
}

import UIKit

final class MoviesListCell: UICollectionViewListCell {
    private let rankStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.spacing = 4
        return stackView
    }()
    private let titleAndAudienceStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        stackView.spacing = 4
        return stackView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .black
        return label
    }()
    private let changeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .red
        return label
    }()
    private let audienceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MoviesListCell {
    private func setupViews() {
        addSubview(rankStackView)
        rankStackView.addArrangedSubview(rankLabel)
        rankStackView.addArrangedSubview(changeLabel)
        
        addSubview(titleAndAudienceStackView)
        titleAndAudienceStackView.addArrangedSubview(titleLabel)
        titleAndAudienceStackView.addArrangedSubview(audienceLabel)
        
        rankStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rankStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            rankStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35)
        ])
        
        titleAndAudienceStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleAndAudienceStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleAndAudienceStackView.leadingAnchor.constraint(equalTo: rankStackView.leadingAnchor, constant: 50)
        ])
    }
    
    func configure(with viewModel: MoviesCellViewModel) {
        titleLabel.text = viewModel.movieName
        rankLabel.text = viewModel.rank
        changeLabel.text = viewModel.rankChangeText
        changeLabel.textColor = viewModel.rankChangeColor
        audienceLabel.text = viewModel.audienceText
    }
}

import UIKit

extension UILabel {
    convenience init(font: UIFont, textColor: UIColor) {
        self.init()
        self.font = font
        self.textColor = textColor
    }
}

class MoviesListCell: UICollectionViewCell {
    private let titleLabel = UILabel(font: .systemFont(ofSize: 15), textColor: .black)
    private let rankLabel = UILabel(font: .boldSystemFont(ofSize: 25), textColor: .black)
    private let changeLabel = UILabel(font: .systemFont(ofSize: 13), textColor: .red)
    private let audienceLabel = UILabel(font: .systemFont(ofSize: 14), textColor: .gray)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(rankLabel)
        addSubview(changeLabel)
        addSubview(audienceLabel)
        
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rankLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            rankLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30)
        ])
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: rankLabel.leadingAnchor, constant: 40)
        ])
        changeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            changeLabel.topAnchor.constraint(equalTo: rankLabel.bottomAnchor, constant: 3),
            changeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30)
        ])
        audienceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            audienceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
            audienceLabel.leadingAnchor.constraint(equalTo: changeLabel.trailingAnchor, constant: 30)
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

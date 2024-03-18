import UIKit

final class MoviesListCell: UICollectionViewListCell {
    private let rankStackView = UIStackView().makeStackView(axis: .vertical, alignment: .center, spacing: 4)
    private let titleAndAudienceStackView = UIStackView().makeStackView(axis: .vertical, alignment: .fill, spacing: 4)
    private let titleLabel = UILabel().makeCellLabel(fontSize: 15, textColor: .black)
    private let rankLabel = UILabel().makeCellLabel(fontSize: 25, textColor: .black)
    private let changeLabel = UILabel().makeCellLabel(fontSize: 13, textColor: .red)
    private let audienceLabel = UILabel().makeCellLabel(fontSize: 14, textColor: .gray)
    
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
    
    func configure(with cellInformaition: (String, String, String, UIColor, String)) {
        titleLabel.text = cellInformaition.0
        rankLabel.text = cellInformaition.1
        changeLabel.text = cellInformaition.2
        changeLabel.textColor = cellInformaition.3
        audienceLabel.text = cellInformaition.4
    }
}

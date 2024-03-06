//
//  BoxOfficeCollectionViewCell.swift
//  BoxOffice
//
//  Created by LeeSeongYeon on 2024/02/21.
//

import UIKit

final class BoxOfficeCollectionViewCell: UICollectionViewListCell {
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()

    let rankStackView: UIStackView = {
        let rankStackView = UIStackView()
        rankStackView.axis = .vertical
        rankStackView.distribution = .fillProportionally
        return rankStackView
    }()
    
    let rankLabel: UILabel = {
        let label = UILabel()
        label.font  = .preferredFont(forTextStyle: .largeTitle)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    let rankStatusLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    let rankChangedAmountStackView: UIStackView = {
        let rankChangedAmountStackView = UIStackView()
        rankChangedAmountStackView.axis = .horizontal
        rankChangedAmountStackView.distribution = .fillEqually
        return rankChangedAmountStackView
    }()
    
    let rankChangedIndicatorImageView: UIImageView = {
        let rankChangedIndicatorImageView = UIImageView(image: nil)
        rankChangedIndicatorImageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        rankChangedIndicatorImageView.contentMode = .right
        return rankChangedIndicatorImageView
    }()
    
    let rankChangedAmountLabel: UILabel = {
        let rankChangedAmountLabel = UILabel()
        rankChangedAmountLabel.textAlignment = .left
        rankChangedAmountLabel.font = .preferredFont(forTextStyle: .footnote)
        return rankChangedAmountLabel
    }()
    
    let informationStackView: UIStackView = {
        let informationStackView = UIStackView()
        informationStackView.axis = .vertical
        informationStackView.distribution = .fillEqually
        return informationStackView
    }()
    
    let movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.textAlignment = .left
        return label
    }()
    
    let audienceLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.accessories.append(.disclosureIndicator())
        setupSubView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BoxOfficeCollectionViewCell {
    func configure(data: DailyBoxOffice.Movie) {
        rankLabel.text = String(data.rank)
        
        switch data.rankStatus {
        case .new:
            addRankStatusLabel(text: "신작")
            rankStatusLabel.textColor = .systemRed
        case .old:
            applyRankChangedAmountIntoRankStackView(rankChangedAmount: data.rankChangedAmount)
        }
    
        movieNameLabel.text = data.movieName
        audienceLabel.text = "오늘 \(data.audienceCount.formatNumber()) / 총 \(data.audienceAccumulated.formatNumber())"
    }
    
    private func applyRankChangedAmountIntoRankStackView(rankChangedAmount: Int) {
        let text = String(abs(rankChangedAmount))
        switch rankChangedAmount {
        case 0:
            addRankStatusLabel(text: "-")
        case ..<0:
            addRankChangedAmountStackView(image: UIImage(systemName: "arrowtriangle.down.fill"), tintColor: .systemBlue, text: text)
        case 1...:
            addRankChangedAmountStackView(image: UIImage(systemName: "arrowtriangle.up.fill"), tintColor: .systemRed, text: text)
        default:
            return
        }
    }
    
    private func addRankChangedAmountStackView(image: UIImage?, tintColor: UIColor, text: String) {
        rankStatusLabel.removeFromSuperview()
        
        rankChangedIndicatorImageView.image = image
        rankChangedIndicatorImageView.tintColor = tintColor
        rankChangedAmountLabel.text = text
        
        rankChangedAmountStackView.addArrangedSubview(rankChangedIndicatorImageView)
        rankChangedAmountStackView.addArrangedSubview(rankChangedAmountLabel)
        
        rankStackView.addArrangedSubview(rankChangedAmountStackView)
    }
    
    private func addRankStatusLabel(text: String) {
        rankChangedAmountStackView.removeFromSuperview()
        rankStatusLabel.text = text
        rankStatusLabel.textColor = .gray
        rankStackView.addArrangedSubview(rankStatusLabel)
    }
}

extension BoxOfficeCollectionViewCell {
    private func setupSubView() {
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(rankStackView)
        stackView.addArrangedSubview(informationStackView)
        
        rankStackView.addArrangedSubview(rankLabel)
        rankStackView.addArrangedSubview(rankStatusLabel)
        
        informationStackView.addArrangedSubview(movieNameLabel)
        informationStackView.addArrangedSubview(audienceLabel)
    }
    
    private func setupConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        rankStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            rankStackView.topAnchor.constraint(equalTo: stackView.topAnchor),
            rankStackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            rankStackView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.2)
        ])
    }
}

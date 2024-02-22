//
//  BoxOfficeCollectionViewCell.swift
//  BoxOffice
//
//  Created by LeeSeongYeon on 2024/02/21.
//

import UIKit

class BoxOfficeCollectionViewCell: UICollectionViewListCell {
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
        label.textColor = .red
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
    func addRankChangedAmountStackView(image: UIImage?, tintColor: UIColor, text: String) {
        remove()
        
        rankChangedIndicatorImageView.image = image
        rankChangedIndicatorImageView.tintColor = tintColor
        rankChangedAmountLabel.text = text
        
        rankChangedAmountStackView.addArrangedSubview(rankChangedIndicatorImageView)
        rankChangedAmountStackView.addArrangedSubview(rankChangedAmountLabel)
        
        rankStackView.addArrangedSubview(rankLabel)
        rankStackView.addArrangedSubview(rankChangedAmountStackView)
    }
    
    func addRankStatusLabel(text: String) {
        remove()
        
        rankStatusLabel.text = text
        
        rankStackView.addArrangedSubview(rankLabel)
        rankStackView.addArrangedSubview(rankStatusLabel)
    }
    
    func remove() {
        rankStackView.arrangedSubviews.forEach { view in
            rankStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
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

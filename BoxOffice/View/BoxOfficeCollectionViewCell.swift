//
//  BoxOfficeCollectionViewCell.swift
//  BoxOffice
//
//  Created by LeeSeongYeon on 2024/02/21.
//

import UIKit

class BoxOfficeCollectionViewCell: UICollectionViewListCell {
    let rankLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font  = .preferredFont(forTextStyle: .largeTitle)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    let rankStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "신작"
        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        label.textColor = .red
        return label
    }()
    
    let movieNameLabel: UILabel = {
        let label = UILabel()
        label.text = "경관의 피"
        label.font = .preferredFont(forTextStyle: .title3)
        label.textAlignment = .left
        return label
    }()
    
    let audienceLabel: UILabel = {
        let label = UILabel()
        label.text = "ddd/ddd"
        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .left
        return label
    }()
    
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
    
    let informationStackView: UIStackView = {
        let informationStackView = UIStackView()
        informationStackView.axis = .vertical
        informationStackView.distribution = .fillEqually
        return informationStackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            rankStackView.topAnchor.constraint(equalTo: stackView.topAnchor),
            rankStackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            rankStackView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.2),
            rankStackView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

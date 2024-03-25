//
//  BoxOfficeCollectionViewCell.swift
//  BoxOffice
//
//  Created by nayeon  on 2/26/24.
//

import UIKit

final class BoxOfficeCollectionViewCell: UICollectionViewCell {

    private let rankLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private let rankChangeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var rankStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [rankLabel, rankChangeLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 3
        return stackView
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, detailLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    private let accessoryButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension BoxOfficeCollectionViewCell {
    
    private func configureUI() {
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.2
    }
    
    private func setUpLayout() {
        contentView.addSubview(titleStackView)
        contentView.addSubview(rankStackView)
        contentView.addSubview(accessoryButton)
        
        setUpRankStackVeiwConstraint()
        setUpMovieInfomationStackViewConstraint()
        setUpAccessoryButtonViewConstraint()
    }

    private func setUpRankStackVeiwConstraint() {
        NSLayoutConstraint.activate([
            rankStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rankStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            rankStackView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setUpMovieInfomationStackViewConstraint() {
        NSLayoutConstraint.activate([
            titleStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor, constant: 30),
            titleStackView.trailingAnchor.constraint(equalTo: accessoryButton.leadingAnchor, constant: -20)
        ])
    }

    private func setUpAccessoryButtonViewConstraint() {
        NSLayoutConstraint.activate([
            accessoryButton.widthAnchor.constraint(equalToConstant: 20),
            accessoryButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            accessoryButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func configure(with boxOffice: BoxOfficeEntity) {
        rankLabel.text = boxOffice.rank
        titleLabel.text = boxOffice.movieName
        detailLabel.text = "오늘: \(boxOffice.salesAmount.formatNumberString()) / 총: \(boxOffice.audienceCount.formatNumberString())"
        
        if boxOffice.isNewMovie {
            rankChangeLabel.text = "신작"
            return
        }
        
        if let rankChangeValue = Int(boxOffice.rankChangeValue) {
            if rankChangeValue > 0 {
                rankChangeLabel.text = "🔺 \(String(rankChangeValue).formatNumberString())"
                rankChangeLabel.textColor = .red
            } else if rankChangeValue < 0 {
                rankChangeLabel.text = "🔻 \(String(-rankChangeValue).formatNumberString())"
                rankChangeLabel.textColor = .blue
            } else {
                rankChangeLabel.text = "-"
                rankChangeLabel.textColor = .black
            }
        }
    }
}

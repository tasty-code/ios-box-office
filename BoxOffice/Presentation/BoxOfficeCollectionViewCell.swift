//
//  BoxOfficeCollectionViewCell.swift
//  BoxOffice
//
//  Created by nayeon  on 2/26/24.
//

import UIKit

class BoxOfficeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BoxOfficeCollectionViewCell"

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
    
    private lazy var rankStactkView: UIStackView = {
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
        setupUI()
        configureUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
}

extension BoxOfficeCollectionViewCell {
    func setupUI() {
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.2
    }
    
    func configureUI() {
        contentView.addSubview(titleStackView)
        contentView.addSubview(rankStactkView)
        contentView.addSubview(accessoryButton)
    }

    func setupConstraint() {
        setupRankStackVeiwConstraint()
        setupMovieInfomationStackViewConstraint()
        setupAccessoryButtonViewConstraint()
    }

    func setupRankStackVeiwConstraint() {
        NSLayoutConstraint.activate([
            rankStactkView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rankStactkView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            rankStactkView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }

    func setupMovieInfomationStackViewConstraint() {
        NSLayoutConstraint.activate([
            titleStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: rankStactkView.trailingAnchor, constant: 30),
            titleStackView.trailingAnchor.constraint(equalTo: accessoryButton.leadingAnchor, constant: -20)
        ])
    }

    func setupAccessoryButtonViewConstraint() {
        NSLayoutConstraint.activate([
            accessoryButton.widthAnchor.constraint(equalToConstant: 20),
            accessoryButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            accessoryButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func configure(with boxOffice: BoxOfficeEntity) {
        rankLabel.text = boxOffice.rank
        titleLabel.text = boxOffice.movieName
        detailLabel.text = "오늘: \(boxOffice.salesAmount) / 총: \(boxOffice.audienceCount)"
        
        if boxOffice.isNewMovie {
            rankChangeLabel.text = "신작"
        }
        
        if let rankChangeValue = Int(boxOffice.rankChangeValue) {
            if rankChangeValue > 0 {
                rankChangeLabel.text = "🔺 \(String(rankChangeValue))"
                rankChangeLabel.textColor = .red
            } else if rankChangeValue < 0 {
                rankChangeLabel.text = "🔻 \(String(-rankChangeValue))"
                rankChangeLabel.textColor = .blue
            } else {
                rankChangeLabel.text = "-"
                rankChangeLabel.textColor = .black
            }
        }
    }
}

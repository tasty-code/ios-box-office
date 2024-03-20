//
//  BoxOfficeCollectionViewCell.swift
//  BoxOffice
//
//  Created by Jin-Mac on 3/20/24.
//

import UIKit

class BoxOfficeCollectionViewListCell: UICollectionViewListCell {
    // MARK: - Public Property
    
    static let identifier = "BoxOfficeCollectionViewListCell"
    
    // MARK: - Private Property
    
    var movieData: DailyBoxOfficeList? {
        didSet {
            updateDailyBoxOfficeCellLabel()
        }
    }
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
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
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, detailLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        accessories = [.disclosureIndicator()]
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BoxOfficeCollectionViewListCell {
    
    // MARK: - Private Function
    
    private func updateDailyBoxOfficeCellLabel() {
        rankLabel.text = movieData?.rank
        titleLabel.text = movieData?.movieName
        detailLabel.text = "오늘 \(movieData?.audienceDailyCount ?? "Null") / 총 \(movieData?.audienceTotalAmount ?? "Null")"
    }
    
    private func setUpLayout() {
        contentView.addSubview(titleStackView)
        contentView.addSubview(rankStackView)
        
        setUpRankStackVeiwConstraint()
        setUpMovieInfomationStackViewConstraint()
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
            titleStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
}

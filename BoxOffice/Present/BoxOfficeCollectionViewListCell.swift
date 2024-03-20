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
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BoxOfficeCollectionViewListCell {
    
    // MARK: - Private Function
    
    private func configureUI() {
        contentView.addSubview(titleStackView)
        contentView.addSubview(rankStackView)
        
        configureConstraint()
    }

    private func configureConstraint() {
        NSLayoutConstraint.activate([
            rankStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rankStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            rankStackView.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            titleStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor, constant: 30),
            titleStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    private func updateDailyBoxOfficeCellLabel() {
        rankLabel.text = movieData?.rank
        titleLabel.text = movieData?.movieName
        detailLabel.text = "오늘 \(movieData?.audienceDailyCount.formatNumberString() ?? "Null") / 총 \(movieData?.audienceTotalAmount.formatNumberString() ?? "Null")"
        formatMovieLabel()
    }
    
    private func formatMovieLabel() {
        
        guard let newOrOld = movieData?.rankOldAndNew else {
            rankChangeLabel.text = "Null"
            return
        }
        
        guard newOrOld != .new else {
            rankChangeLabel.text = "신작"
            rankChangeLabel.textColor = .red
            return
        }
        
        if let rankChangeValue = movieData?.rankIncrement, let rankChangeValue = Int(rankChangeValue) {
            
            guard rankChangeValue != 0 else {
                rankChangeLabel.text = "-"
                rankChangeLabel.textColor = .black
                return
            }
            
            rankChangeLabel.text = rankChangeValue < 0 ? "▼" : "▲"
            let charactersColor:UIColor = rankChangeValue < 0 ? .blue : .red
            rankChangeLabel.text! += String(rankChangeValue).formatNumberString()
            rankChangeLabel.setTextColor(charactersColor, range: NSRange(location: 0, length: 1))
        }
    }
}

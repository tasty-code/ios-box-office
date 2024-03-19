//
//  MovieListCollectionViewCell.swift
//  BoxOffice
//
//  Created by dopamint on 3/14/24.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MovieListCollectionViewCell"
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
        return label
    }()
    
    private let rankChangeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedString = NSMutableAttributedString(string: "순위변경")
        label.font = UIFont.systemFont(ofSize: 14)
        label.baselineAdjustment = .alignCenters
        return label
    }()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        return label
    }()
    
    private let audienceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var rankStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addSubview(rankLabel)
        stackView.addSubview(rankChangeLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        
        return stackView
    }()
    
    private lazy var movieTitleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [movieTitleLabel, audienceLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var accessoryButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureBorder()
        setupUI()
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension MovieListCollectionViewCell {
    
    private func configureBorder() {
        layer.borderWidth = 0.2
        layer.borderColor = UIColor.lightGray.cgColor
    }
    private func setupUI() {
        contentView.addSubview(rankStackView)
        contentView.addSubview(movieTitleStackView)
        contentView.addSubview(accessoryButton)
        
        setupRankStackViewConstraint()
        setupMovieTitleStackViewConstraint()
        setupCellAccessoryButtonConstraint()
    }
    
    private func setupRankStackViewConstraint() {
        NSLayoutConstraint.activate([
            rankStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1),
            rankStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 1),
            rankStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            rankStackView.widthAnchor.constraint(equalToConstant: 60),
            rankLabel.centerXAnchor.constraint(equalTo: rankStackView.centerXAnchor),
            rankChangeLabel.centerXAnchor.constraint(equalTo: rankStackView.centerXAnchor),
            rankLabel.topAnchor.constraint(equalTo: rankStackView.topAnchor, constant: 10),
            rankChangeLabel.topAnchor.constraint(equalTo: rankLabel.bottomAnchor)
        ])
    }
    
    private func setupMovieTitleStackViewConstraint() {
        NSLayoutConstraint.activate([
            movieTitleStackView.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor, constant: 30),
            movieTitleStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16)
        ])
    }
    
    private func setupCellAccessoryButtonConstraint() {
        NSLayoutConstraint.activate([
            accessoryButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            accessoryButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            accessoryButton.widthAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    func configureCell(with movieInfo: DailyBoxOfficeDTO.BoxOfficeDTO.MovieInfo) {
        rankLabel.text = movieInfo.rank
        rankChangeLabel.text = movieInfo.rankChanges
        movieTitleLabel.text = movieInfo.movieName
        audienceLabel.text = "오늘 :\(movieInfo.audienceCount.formatNumberString())명 / 총 :\( movieInfo.audienceAccumulated.formatNumberString())명"
        
        if movieInfo.rankOldAndNew == "NEW" {
            rankChangeLabel.text = "신작"
            return
        }
        
        if let rankChangeValue = Int(movieInfo.rankChanges) {
            if rankChangeValue > 0 {
                rankChangeLabel.text = "▲ \(movieInfo.rankChanges)"
                rankChangeLabel.textColor = .red
            } else if rankChangeValue < 0 {
                rankChangeLabel.text = "▼ \(movieInfo.rankChanges)"
                rankChangeLabel.textColor = .blue
            } else {
                rankChangeLabel.text = "-"
                rankChangeLabel.textColor = .black
            }
        }
    }
    
}

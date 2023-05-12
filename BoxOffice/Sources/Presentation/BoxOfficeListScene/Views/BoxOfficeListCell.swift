//
//  BoxOfficeListCell.swift
//  BoxOffice
//
//  Created by Mason Kim on 2023/05/02.
//

import UIKit

final class BoxOfficeListCell: UICollectionViewListCell {
    
    // MARK: - Constants
    
    private enum Metric {
        static let stackViewSpacing: CGFloat = 8
        static let horizontalInset: CGFloat = 20
    }
    
    private enum Constants {
        static let movieRankLabelSkeletonText = "-"
        static let movieRankStatusLabelSkeletonText = "--"
        static let movieTitleLabelSkeletonText = "----"
        static let audienceCountLabelSkeletonText = "일일 --- / 총 ---"
        
        static let movieRankLabelNewText = "신작"
        
        static let rankStatusUpPrefix = "▲"
        static let rankStatusDownPrefix = "▼"
        static let rankStatusStablePrefix = "-"
    }
    
    struct Item: Hashable {
        let isNew: Bool
        let name: String
        let rank: String
        let rankIntensity: Int
        let audienceCount: String
    }
    
    // MARK: - UI Components
    
    private let movieRankLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.text = Constants.movieRankLabelSkeletonText
        return label
    }()
    
    private let movieRankStatusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .callout)
        label.text = Constants.movieRankStatusLabelSkeletonText
        return label
    }()
    
    private lazy var movieRankStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            movieRankLabel,
            movieRankStatusLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = Metric.stackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.text = Constants.movieTitleLabelSkeletonText
        return label
    }()
    
    private let audienceCountLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        label.text = Constants.audienceCountLabelSkeletonText
        return label
    }()
    
    private lazy var movieInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            movieTitleLabel,
            audienceCountLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = Metric.stackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle

    override func prepareForReuse() {
        super.prepareForReuse()
        resetUIComponents()
    }
    
    // MARK: - Public Methods
    
    func configure(with item: BoxOfficeListCell.Item) {
        movieRankLabel.text = item.rank
        movieRankStatusLabel.attributedText = movieRankStatusLabelText(with: item)
        movieTitleLabel.text = item.name
        audienceCountLabel.text = item.audienceCount
    }
    
    func configure(with movieTitle: String) {
        movieTitleLabel.text = movieTitle
    }
    
    // MARK: - Private Methods
    
    private func resetUIComponents() {
        movieRankLabel.text = ""
        movieRankStatusLabel.attributedText = NSAttributedString(string: "")
        movieTitleLabel.text = ""
        audienceCountLabel.text = ""
        movieTitleLabel.text = ""
    }
    
    private func movieRankStatusLabelText(with item: BoxOfficeListCell.Item) -> NSAttributedString {
        if item.isNew {
            return NSAttributedString(string: Constants.movieRankLabelNewText,
                                      attributes: [.foregroundColor: UIColor.systemRed])
        }
        
        let rankIntensity = item.rankIntensity
        
        if rankIntensity == 0 {
            return NSAttributedString(string: Constants.rankStatusStablePrefix)
        }
        
        let prefix = rankIntensity > 0 ? Constants.rankStatusUpPrefix : Constants.rankStatusDownPrefix
        let prefixColor: UIColor = rankIntensity > 0 ? .systemRed : .systemBlue
        
        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(NSAttributedString(string: prefix,
                                                          attributes: [.foregroundColor: prefixColor]))
        
        let absoluteRankIntensity = String(abs(rankIntensity))
        mutableAttributedString.append(NSAttributedString(string: absoluteRankIntensity))
        return mutableAttributedString
        
    }
    
    private func audienceCountLabelText(with dailyBoxOffice: DailyBoxOffice) -> String {
        
        guard let formattedDailyAudienceCount = Int(dailyBoxOffice.dailyAudienceCount)?.formatWithCommas(),
              let formattedCumulativeAudience = Int(dailyBoxOffice.cumulativeAudience)?.formatWithCommas() else {
            return ""
        }
        return "일일 \(formattedDailyAudienceCount) / 총 \(formattedCumulativeAudience)"
    }
}

// MARK: - UI & Layout

extension BoxOfficeListCell {
    
    private func setup() {
        setUI()
        setLayout()
    }
    
    private func setUI() {
        addAccessory()
    }
    
    private func setLayout() {
        
        contentView.addSubview(movieRankStackView)
        NSLayoutConstraint.activate([
            movieRankStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                        constant: Metric.horizontalInset),
            movieRankStackView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                    constant: 10),
            movieRankStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                       constant: -10),
            movieRankStackView.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        contentView.addSubview(movieInfoStackView)
        NSLayoutConstraint.activate([
            movieInfoStackView.leadingAnchor.constraint(equalTo: movieRankStackView.trailingAnchor,
                                                        constant: Metric.horizontalInset),
            movieInfoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                         constant: -30),
            movieInfoStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    private func addAccessory() {
        accessories = [
            .disclosureIndicator()
        ]
    }
}

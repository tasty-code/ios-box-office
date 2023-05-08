//
//  BoxOfficeListCell.swift
//  BoxOffice
//
//  Created by Mason Kim on 2023/05/02.
//

import UIKit

final class BoxOfficeListCell: UICollectionViewListCell {
    
    // MARK: - Constants
    
    enum Metric {
        static let movieRankStackViewSpacing = 8.f
        static let movieRankStackViewLeadingInset = 20.f
        static let movieRanckStackViewVerticalInset = 10.f
        static let movieRanckStackViewWidth = 50.f
        static let movieInfoStackViewSpacing = 8.f
        static let movieInfoStackViewLeadingInset = 20.f
        static let movieInfoStackViewTrailingInset = 30.f
    }
    
    enum Constants {
        static let movieRankLabelSkeletonText = "-"
        static let movieRankStatusLabelSkeletonText = "--"
        static let movieTitleLabelSkeletonText = "----"
        static let audienceCountLabelSkeletonText = "일일 --- / 총 ---"
        
        static let movieRankLabelNewText = "신작"
        
        static let rankStatusUpPrefix = "▲"
        static let rankStatusDownPrefix = "▼"
        static let rankStatusStablePrefix = "-"
    }
    
    // MARK: - Properties
    
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
        stackView.spacing = Metric.movieRankStackViewSpacing
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
        stackView.spacing = Metric.movieInfoStackViewSpacing
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
    
    // MARK: - Public Methods
    
    func configure(with item: BoxOfficeListViewModel.BoxOfficeCellItem) {
        movieRankLabel.text = item.movieRankLabelText
        movieRankStatusLabel.attributedText = movieRankStatusLabelText(with: item)
        movieTitleLabel.text = item.movieTitleLabelText
        audienceCountLabel.text = item.audienceCountLabelText
    }
    
    func configure(with movieTitle: String) {
        movieTitleLabel.text = movieTitle
    }
    
    // MARK: - Private Methods
    
    private func movieRankStatusLabelText(with item: BoxOfficeListViewModel.BoxOfficeCellItem) -> NSAttributedString {
        if item.isNew {
            return NSAttributedString(string: Constants.movieRankLabelNewText,
                                      attributes: [.foregroundColor: UIColor.systemRed])
        }
        
        let rankIntensity = item.movieRankIntensity
        
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
        
        addSubview(movieRankStackView)
        NSLayoutConstraint.activate([
            movieRankStackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                        constant: Metric.movieRankStackViewLeadingInset),
            movieRankStackView.topAnchor.constraint(equalTo: topAnchor,
                                                    constant: Metric.movieRanckStackViewVerticalInset),
            movieRankStackView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                       constant: -Metric.movieRanckStackViewVerticalInset),
            movieRankStackView.widthAnchor.constraint(equalToConstant: Metric.movieRanckStackViewWidth)
        ])
        
        addSubview(movieInfoStackView)
        NSLayoutConstraint.activate([
            movieInfoStackView.leadingAnchor.constraint(equalTo: movieRankStackView.trailingAnchor,
                                                        constant: Metric.movieInfoStackViewLeadingInset),
            movieInfoStackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                         constant: -Metric.movieInfoStackViewTrailingInset),
            movieInfoStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func addAccessory() {
        accessories = [
            .disclosureIndicator()
        ]
    }
}

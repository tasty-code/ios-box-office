//
//  BoxOfficeListCell.swift
//  BoxOffice
//
//  Created by Mason Kim on 2023/05/02.
//

import UIKit

final class BoxOfficeListCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    enum Metric {
        static let movieRankStackViewSpacing = 8.f
        static let movieRankStackViewLeadingInset = 20.f
        static let movieInfoStackViewSpacing = 8.f
        static let movieInfoStackViewLeadingInset = 20.f
    }
    
    enum Constants {
        static let movieRankLabelSkeletonText: String = "-"
        static let movieRankStatusLabelSkeletonText: String = "--"
        static let movieTitleLabelSkeletonText: String = "----"
        static let audienceCountLabelSkeletonText: String = "오늘 --- / 총 ---"
    }
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    private let movieRankLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.text = Constants.movieRankLabelSkeletonText
        return label
    }()
    
    private let movieRankStatusLabel: UILabel = {
        let label = UILabel()
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
        return stackView
    }()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
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
    
    // MARK: - Private Methods
    
}

// MARK: - UI & Layout

extension BoxOfficeListCell {
    private func setup() {
        setUI()
        setLayout()
    }
    
    private func setUI() {
        
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 100)
        ])
        
        addSubview(movieRankStackView)
        movieRankStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieRankStackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                        constant: Metric.movieRankStackViewLeadingInset),
            movieRankStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        addSubview(movieInfoStackView)
        movieInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieInfoStackView.leadingAnchor.constraint(equalTo: movieRankStackView.trailingAnchor,
                                                        constant: Metric.movieInfoStackViewLeadingInset),
            movieInfoStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

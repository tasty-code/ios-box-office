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
    }
    
    enum Constants {
        static let movieRankLabelSkeletonText: String = "-"
        static let movieRankStatusLabelSkeletonText: String = "-0"
    }
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    private let movieRankLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
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
        addSubview(movieRankStackView)
        movieRankStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieRankStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieRankStackView.topAnchor.constraint(equalTo: topAnchor),
            movieRankStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

//
//  DailyBoxOfficeCell.swift
//  BoxOffice
//
//  Created by 김용재 on 2023/05/08.
//

import UIKit

final class DailyBoxOfficeCell: UICollectionViewListCell {

    private enum Constants {
        static let movieTitleLabelFontSize: CGFloat = 21.0
        static let audienceLabelFontSize: CGFloat = 17.0
        static let dailyRankNumberLabelFontSize: CGFloat = 35.0
        static let dailyRankChangesLabelFontSize: CGFloat = 17.0

        static let rankStackViewWidth: CGFloat = 80
        static let rankStackViewleadingInset: CGFloat = 10
        static let rankStackViewInset: CGFloat = 7.0

        static let titleStackViewInset: CGFloat = 16.0
    }

    static let identifier = String(describing: DailyBoxOfficeCell.self)

    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: movieTitleFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let audienceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: audienceLabelFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let rankNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: dailyRankNumberLabelFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let dailyRankChangesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: dailyRankChangesLabelFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)

        configureHierarchy()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

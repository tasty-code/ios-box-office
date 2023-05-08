//
//  DailyBoxOfficeCell.swift
//  BoxOffice
//
//  Created by 김용재 on 2023/05/08.
//

import UIKit

final class DailyBoxOfficeCell: UICollectionViewListCell {

    static let identifier = String(describing: DailyBoxOfficeCell.self)

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

    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        return formatter
    }()

    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.movieTitleLabelFontSize)

        return label
    }()

    private let audienceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.audienceLabelFontSize)

        return label
    }()

    private let rankNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.dailyRankNumberLabelFontSize)

        return label
    }()

    private let dailyRankChangesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.dailyRankChangesLabelFontSize)

        return label
    }()

    private let rankVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally

        return stackView
    }()

    private let titleAudienceVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally

        return stackView
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)

        configureHierarchy()
        configureConstraints()
    }

    func configure(with movie: DailyBoxOffice) {
        movieTitleLabel.text = movie.movieName
        audienceLabel.text = movie.rank
        audienceLabel.text = generateAudienceLabelText(with: movie)
    }

    private func configureHierarchy() {
        rankVerticalStackView.addArrangedSubview(rankNumberLabel)
        rankVerticalStackView.addArrangedSubview(dailyRankChangesLabel)

        titleAudienceVerticalStackView.addArrangedSubview(movieTitleLabel)
        titleAudienceVerticalStackView.addArrangedSubview(audienceLabel)

        addSubview(rankVerticalStackView)
        addSubview(titleAudienceVerticalStackView)
    }

    private func configureConstraints() {
        let cellHeightConstraint = contentView.heightAnchor.constraint(equalToConstant: 80)
        cellHeightConstraint.priority = .defaultHigh
        cellHeightConstraint.isActive = true

        rankVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        rankVerticalStackView.widthAnchor.constraint(equalToConstant: Constants.rankStackViewWidth).isActive = true
        rankVerticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.rankStackViewInset).isActive = true
        rankVerticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.rankStackViewInset).isActive = true
        rankVerticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.rankStackViewleadingInset).isActive = true

        titleAudienceVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        titleAudienceVerticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.titleStackViewInset).isActive = true
        titleAudienceVerticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.titleStackViewInset).isActive = true
        titleAudienceVerticalStackView.leadingAnchor.constraint(equalTo: rankVerticalStackView.trailingAnchor, constant: .zero).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func generateAudienceLabelText(with movie: DailyBoxOffice) -> String {
        let audienceAccumulationNumber = movie.audienceAccumulation
        let audienceCountNumber = movie.audienceCount

        guard let audienceAccumulation = numberFormatter.string(for: audienceAccumulationNumber) else {
            return String(audienceAccumulationNumber)
        }
        guard let dailyAudienceCount = numberFormatter.string(for: audienceCountNumber) else {
            return String(audienceCountNumber)
        }

        let audienceLabelText = "오늘 \(dailyAudienceCount) / 총 \(audienceAccumulation)"

        return audienceLabelText
    }

}

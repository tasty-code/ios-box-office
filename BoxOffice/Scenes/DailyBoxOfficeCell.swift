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

        static let upSymbolName: String = "arrowtriangle.up.fill"
        static let downSymbolName: String = "arrowtriangle.down.fill"
        static let noneChangeOfRankState: String = "-"
        static let rankNewState: String = "신작"
        static let today: String = "오늘 "
        static let total: String = " / 총 "

        static let movieTitleLabelFontSize: CGFloat = 21.0
        static let audienceLabelFontSize: CGFloat = 17.0
        static let dailyRankNumberLabelFontSize: CGFloat = 35.0
        static let dailyRankChangesLabelFontSize: CGFloat = 17.0

        static let rankStackViewWidth: CGFloat = 80
        static let rankStackViewleadingInset: CGFloat = 10
        static let rankStackViewInset: CGFloat = 7.0

        static let titleStackViewInset: CGFloat = 16.0
        static let titleStackViewTrailingInset: CGFloat = 40.0
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
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private let titleAudienceVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureHierarchy()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureHierarchy() {
        addSubview(rankVerticalStackView)
        rankVerticalStackView.addArrangedSubview(rankNumberLabel)
        rankVerticalStackView.addArrangedSubview(dailyRankChangesLabel)

        addSubview(titleAudienceVerticalStackView)
        titleAudienceVerticalStackView.addArrangedSubview(movieTitleLabel)
        titleAudienceVerticalStackView.addArrangedSubview(audienceLabel)
    }

    private func configureConstraints() {
        let cellHeightConstraint = contentView.heightAnchor.constraint(equalToConstant: 80)
        cellHeightConstraint.priority = .defaultHigh
        cellHeightConstraint.isActive = true

        rankVerticalStackView.widthAnchor.constraint(equalToConstant: Constants.rankStackViewWidth).isActive = true
        rankVerticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.rankStackViewInset).isActive = true
        rankVerticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.rankStackViewInset).isActive = true
        rankVerticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.rankStackViewleadingInset).isActive = true

        titleAudienceVerticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.titleStackViewInset).isActive = true
        titleAudienceVerticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.titleStackViewInset).isActive = true
        titleAudienceVerticalStackView.leadingAnchor.constraint(equalTo: rankVerticalStackView.trailingAnchor, constant: .zero).isActive = true
        titleAudienceVerticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.titleStackViewTrailingInset).isActive = true
    }

    func configure(with movie: DailyBoxOffice) {
        movieTitleLabel.text = movie.movieName
        rankNumberLabel.text = movie.rank
        audienceLabel.text = generateAudienceLabelText(with: movie)
        setDailyRankChangesLabelText(with: movie)
    }

    private func generateAudienceLabelText(with movie: DailyBoxOffice) -> String {
        var audienceLabelText = Constants.today + movie.audienceAccumulation + Constants.total + movie.audienceCount

        guard let audienceAccumulationNumber = Int(movie.audienceAccumulation),
              let audienceCountNumber = Int(movie.audienceCount) else { return audienceLabelText }

        let audienceAccumulation =  audienceAccumulationNumber.decimalizedString
        let dailyAudienceCount = audienceCountNumber.decimalizedString

        audienceLabelText = Constants.today + dailyAudienceCount + Constants.total + audienceAccumulation

        return audienceLabelText
    }

    private func setDailyRankChangesLabelText(with movie: DailyBoxOffice) {
        switch movie.rankOldAndNew {
        case .new:
            dailyRankChangesLabel.text = Constants.rankNewState
            dailyRankChangesLabel.textColor = UIColor.systemRed
            return
        case .old:
            setOldRankChangesLabelText(with: movie)
            return
        }
    }

    private func setOldRankChangesLabelText(with movie: DailyBoxOffice) {
        guard let dailyRankChanges = Int(movie.dailyRankChanges) else { return }

        if dailyRankChanges == 0 {
            dailyRankChangesLabel.text = Constants.noneChangeOfRankState
            return
        }

        if dailyRankChanges > 0 {
            let image = UIImage(systemName: Constants.upSymbolName)?.withTintColor(.systemRed)
            let dailytRankChangesText = generateRankChangesAttributedText(movie.dailyRankChanges,
                                                                          with: image)
            dailyRankChangesLabel.attributedText = dailytRankChangesText
            return
        }

        if dailyRankChanges < 0 {
            let image = UIImage(systemName: Constants.downSymbolName)?.withTintColor(.systemBlue)
            let dailytRankChangesText = generateRankChangesAttributedText(movie.dailyRankChanges,
                                                                          with: image)
            dailyRankChangesLabel.attributedText = dailytRankChangesText
            return
        }
    }

    private func generateRankChangesAttributedText(_ text: String,
                                                   with image: UIImage?) -> NSMutableAttributedString {
        let attachment = NSTextAttachment()
        attachment.image = image

        let rankChangesAttributedText = NSMutableAttributedString(attachment: attachment)
        let text = NSAttributedString(string: text)
        rankChangesAttributedText.append(text)

        return rankChangesAttributedText
    }

}

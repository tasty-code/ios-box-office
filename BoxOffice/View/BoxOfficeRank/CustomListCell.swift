//
//  CustomListCell.swift
//  BoxOffice
//
//  Created by Blu on 2023/05/10.
//

import UIKit

final class CustomListCell: UICollectionViewListCell {

    var boxOfficeItem: BoxOfficeItem?

    private let rankNumberTextView = UILabel(fontSize: .largeTitle)
    private let rankDetailTextView = UILabel(fontSize: .callout)
    private let movieNameTextView = UILabel(fontSize: .title3)
    private let movieDetailTextView = UILabel()

    override func updateConfiguration(using state: UICellConfigurationState) {

        super.updateConfiguration(using: state)

        configureHierarchy()
        configureSeparator()

        rankNumberTextView.text = boxOfficeItem?.rank.number
        rankDetailTextView.attributedText = boxOfficeItem?.rank.detail
        movieNameTextView.text = boxOfficeItem?.name
        movieDetailTextView.text = boxOfficeItem?.audience

    }

    private func configureSeparator() {

        let constraint = separatorLayoutGuide.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        constraint.isActive = true
    }

    private func configureHierarchy() {

        let rankStackView = UIVerticalStackView(arrangedSubviews: [rankNumberTextView, rankDetailTextView], alignment: .center)

        let movieStackView = UIVerticalStackView(arrangedSubviews: [movieNameTextView, movieDetailTextView], alignment: .leading)

        contentView.addSubview(rankStackView)
        contentView.addSubview(movieStackView)

        NSLayoutConstraint.activate([
            rankStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            rankStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            rankStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            rankStackView.widthAnchor.constraint(lessThanOrEqualToConstant: 50),
            rankStackView.widthAnchor.constraint(equalToConstant: 50),

            movieStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            movieStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            movieStackView.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor, constant: 20)
        ])
    }

}

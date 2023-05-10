//
//  CustomListCell.swift
//  BoxOffice
//
//  Created by Blu on 2023/05/10.
//

import UIKit

final class CustomListCell: UICollectionViewListCell {

    var boxOfficeItem: BoxOfficeItem?

    private let rankNumberTextView: UILabel = {
        let textView = UILabel(frame: .zero)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .preferredFont(forTextStyle: .largeTitle)
        return textView
    }()

    private let rankDetailTextView: UILabel = {
        let textView = UILabel(frame: .zero)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .preferredFont(forTextStyle: .callout)
        return textView
    }()

    private let movieNameTextView: UILabel = {
        let textView = UILabel(frame: .zero)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .preferredFont(forTextStyle: .title3)
        return textView
    }()

    private let movieDetailTextView: UILabel = {
        let textView = UILabel(frame: .zero)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

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

        let rankStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [rankNumberTextView, rankDetailTextView])
            stackView.axis = .vertical
            stackView.alignment = .center
            stackView.translatesAutoresizingMaskIntoConstraints = false

            return stackView
        }()

        let movieStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [movieNameTextView, movieDetailTextView])
            stackView.axis = .vertical
            stackView.alignment = .leading
            stackView.translatesAutoresizingMaskIntoConstraints = false

            return stackView
        }()

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

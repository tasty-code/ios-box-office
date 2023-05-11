//
//  BoxOfficeRank.swift
//  BoxOffice
//
//  Created by 이상윤 on 2023/05/02.
//

import UIKit

final class BoxOfficeRank: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureOfStackView()
        configureOfComponents()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        configureOfStackView()
        configureOfComponents()
    }

    private var information: UIStackView = {
        let information = UIStackView()

        return information
    }()

    private let rank: UILabel = {
        let rankLabel = UILabel()
        rankLabel.font = UIFont.systemFont(ofSize: 30)
        rankLabel.textColor = .black

        return rankLabel
    }()

    private lazy var rankEmoji: UIImageView = {
        let rankEmoji = UIImageView()

        return rankEmoji
    }()

    private let rankVariation: UILabel = {
        let rankVariationLabel = UILabel()
        rankVariationLabel.font = UIFont.systemFont(ofSize: 15)

        return rankVariationLabel
    }()

    private func configureOfStackView() {
        axis = .vertical
        spacing = 3
        alignment = .center
        distribution = .equalSpacing

        information.axis = .horizontal
        information.alignment = .center
        information.distribution = .equalSpacing
    }

    private func configureOfComponents() {
        addArrangedSubview(rank)
        addArrangedSubview(information)
        information.addArrangedSubview(rankEmoji)
        information.addArrangedSubview(rankVariation)
    }
}

extension BoxOfficeRank {

    func setRank(by text: String) {
        rank.text = text
    }

    func setRankVariation(by text: String, with color: UIColor) {
        rankVariation.text = text
        rankVariation.textColor = color
    }

    func setRankVariation(by emoji: UIImage?, with color: UIColor?) {
        rankEmoji.image = emoji
        rankEmoji.tintColor = color
    }
}

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
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    private let rank: UILabel = {
        let rankLabel = UILabel()
        rankLabel.font = .boldSystemFont(ofSize: 35)
        rankLabel.textColor = .black

        return rankLabel
    }()

    private lazy var rankEmoji: UIImageView = {
        let rankEmoji = UIImageView()

        return rankEmoji
    }()

    private let rankVariation: UILabel = {
        let rankVariationLabel = UILabel()

        return rankVariationLabel
    }()

    private func configuration() {
        axis = .vertical
        spacing = 8
        alignment = .center
        distribution = .equalSpacing
    }

    private func configurationOfComponents() {
        addArrangedSubview(rank)
        addArrangedSubview(rankEmoji)
        addArrangedSubview(rankVariation)
    }
}

extension BoxOfficeRank {

    func setRankVariation(by text: String) {
        rankVariation.text = text
    }

    func setRankVaritaion(by color: UIColor) {
        rankVariation.textColor = color
    }

    func setRankVariation(by emoji: UIImage) {
        rankEmoji.image = emoji
    }
}

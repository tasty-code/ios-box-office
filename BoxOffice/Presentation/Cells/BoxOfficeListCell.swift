//
//  BoxOfficeCell.swift
//  BoxOffice
//
//  Created by 이상윤 on 2023/05/02.
//

import UIKit

class BoxOfficeListCell: UICollectionViewListCell {

    static let identifier = String(describing: BoxOfficeListCell.self)

    var boxOfficeRank = BoxOfficeRank()
    var boxOfficeBrief = BoxOfficeBrief()

    override init(frame: CGRect) {
        super .init(frame: frame)
        setUpAllUIComponents()
    }

    required init?(coder: NSCoder) {
        super .init(coder: coder)
        setUpAllUIComponents()
    }
    
    private func setUpAllUIComponents() {

        let contentStackView = UIStackView()
        contentStackView.axis = .horizontal
        contentStackView.alignment = .leading
        contentStackView.distribution = .fill

        addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            contentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])

        contentStackView.addSubview(boxOfficeRank)
        contentStackView.addSubview(boxOfficeBrief)

        boxOfficeRank.translatesAutoresizingMaskIntoConstraints = false
        boxOfficeBrief.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            boxOfficeRank.topAnchor.constraint(equalTo: contentStackView.topAnchor),
            boxOfficeRank.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            boxOfficeRank.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor),
            boxOfficeRank.widthAnchor.constraint(equalTo: contentStackView.widthAnchor, multiplier: 0.25),

            boxOfficeBrief.topAnchor.constraint(equalTo: contentStackView.topAnchor, constant: 7),
            boxOfficeBrief.leadingAnchor.constraint(equalTo: boxOfficeRank.trailingAnchor),
            boxOfficeBrief.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor),
            boxOfficeBrief.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: -7)
        ])
    }
}

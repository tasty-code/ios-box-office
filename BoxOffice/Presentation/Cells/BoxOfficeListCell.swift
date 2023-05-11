//
//  BoxOfficeCell.swift
//  BoxOffice
//
//  Created by 이상윤 on 2023/05/02.
//

import UIKit

class BoxOfficeListCell: UICollectionViewListCell, Gettable {

    var rankView = RankView()
    var summaryInformationView = SummaryInformationView()

    override init(frame: CGRect) {
        super .init(frame: frame)
        configureOfAllUIComponents()
    }

    required init?(coder: NSCoder) {
        super .init(coder: coder)
        configureOfAllUIComponents()
    }
    
    private func configureOfAllUIComponents() {

        let contentStackView = UIStackView()
        contentStackView.axis = .horizontal
        contentStackView.alignment = .leading
        contentStackView.distribution = .fill

        addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            contentStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])

        contentStackView.addSubview(rankView)
        contentStackView.addSubview(summaryInformationView)

        rankView.translatesAutoresizingMaskIntoConstraints = false
        summaryInformationView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            rankView.topAnchor.constraint(equalTo: contentStackView.topAnchor, constant: 7),
            rankView.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            rankView.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: -7),
            rankView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor, multiplier: 0.25),

            summaryInformationView.topAnchor.constraint(equalTo: contentStackView.topAnchor, constant: 7),
            summaryInformationView.leadingAnchor.constraint(equalTo: rankView.trailingAnchor),
            summaryInformationView.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor),
            summaryInformationView.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: -7)
        ])
    }
}

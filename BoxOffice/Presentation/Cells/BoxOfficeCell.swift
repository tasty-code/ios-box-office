//
//  BoxOfficeCell.swift
//  BoxOffice
//
//  Created by 이상윤 on 2023/05/02.
//

import UIKit

class BoxOfficeCell: UICollectionViewCell {

    static let identifier = String(describing: BoxOfficeCell.self)

    var boxOfficeRank = BoxOfficeRank()
    var boxOfficeBrief = BoxOfficeBrief()
    
    private func setUpAllUIComponents() {

        let contentStackView = UIStackView()
        contentStackView.axis = .horizontal
        contentStackView.alignment = .leading
        contentStackView.distribution = .fill

        addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor)
        ])

        contentStackView.addArrangedSubview(boxOfficeRank)
        contentStackView.addArrangedSubview(boxOfficeBrief)
    }
}

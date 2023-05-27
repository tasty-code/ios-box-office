//
//  MovieInformaionView.swift
//  BoxOffice
//
//  Created by Bora Yang on 2023/05/12.
//

import UIKit

class MovieInformaionView: UIStackView {
    private let categoryLabel: UILabel
    private let contentLabel: UILabel

    init(category: String, content: String) {
        categoryLabel = UILabel()
        contentLabel = UILabel()

        super.init(frame: .zero)

        categoryLabel.text = category
        contentLabel.text = content

        axis = .horizontal
        distribution = .fill
        addArrangedSubview(categoryLabel)
        addArrangedSubview(contentLabel)
        setUI()
    }

    func setUI() {
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        categoryLabel.font = UIFont.boldSystemFont(ofSize: 17)
        categoryLabel.textAlignment = .center

        contentLabel.numberOfLines = 0
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

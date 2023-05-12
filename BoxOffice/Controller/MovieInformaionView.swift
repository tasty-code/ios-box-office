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
        distribution = .fillEqually
        addArrangedSubview(categoryLabel)
        addArrangedSubview(contentLabel)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

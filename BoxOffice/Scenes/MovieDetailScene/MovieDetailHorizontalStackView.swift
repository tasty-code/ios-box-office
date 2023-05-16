//
//  MovieDetailHorizontalStackView.swift
//  BoxOffice
//
//  Created by 김용재 on 2023/05/16.
//

import UIKit

class MovieDetailHorizontalStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(views: UIView...) {
        self.init(frame: CGRect())
        configureUI()
    }

    private func configureUI() {
        self.layoutMargins = .init(top: 5.0, left: 3, bottom: 5.0, right: 3)
        self.isLayoutMarginsRelativeArrangement = true
        self.alignment = .fill
        self.axis = .horizontal
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
    }

}

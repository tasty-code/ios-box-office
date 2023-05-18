//
//  MovieDetailHorizontalStackView.swift
//  BoxOffice
//
//  Created by 김용재 on 2023/05/16.
//

import UIKit

final class MovieDetailHorizontalStackView: UIStackView {

    private enum MovieDetailHorizontalStackViewConstant {
        static let topBottomlayoutMargins = 5.0
        static let rightLeftlayoutMargins = 3.0
        static let borderWidth = 1.0
    }

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
        self.layoutMargins = .init(
            top: MovieDetailHorizontalStackViewConstant.topBottomlayoutMargins,
            left: MovieDetailHorizontalStackViewConstant.rightLeftlayoutMargins,
            bottom: MovieDetailHorizontalStackViewConstant.topBottomlayoutMargins,
            right: MovieDetailHorizontalStackViewConstant.rightLeftlayoutMargins
        )
        self.isLayoutMarginsRelativeArrangement = true
        self.alignment = .fill
        self.axis = .horizontal
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = MovieDetailHorizontalStackViewConstant.borderWidth
    }

}

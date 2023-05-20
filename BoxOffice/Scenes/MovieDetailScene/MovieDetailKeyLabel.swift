//
//  MovieDetailKeyLabel.swift
//  BoxOffice
//
//  Created by 김용재 on 2023/05/16.
//

import UIKit

final class MovieDetailKeyLabel: UILabel {

    private enum MovieDetailKeyLabelConstant {
        static let boldFontSize = 18.0
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(text: String) {
        self.init(frame: CGRect())
        self.text = text
        self.translatesAutoresizingMaskIntoConstraints = false
        configureUI()
    }

    private func configureUI() {
        self.font = UIFont.boldSystemFont(ofSize: MovieDetailKeyLabelConstant.boldFontSize)
        self.textAlignment = .center
    }

}

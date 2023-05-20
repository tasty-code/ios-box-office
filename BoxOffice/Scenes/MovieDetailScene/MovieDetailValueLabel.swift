//
//  MovieDetailValueLabel.swift
//  BoxOffice
//
//  Created by 김용재 on 2023/05/16.
//

import UIKit

final class MovieDetailValueLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        self.text = Constant.noneText
        self.textAlignment = .left
        self.numberOfLines = .zero
    }

}

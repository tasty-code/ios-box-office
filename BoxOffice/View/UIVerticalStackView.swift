//
//  UIVerticalStackView.swift
//  BoxOffice
//
//  Created by Blu on 2023/05/10.
//

import UIKit

final class UIVerticalStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.axis = .vertical
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(arrangedSubviews: [UIView], alignment: UIStackView.Alignment) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.alignment = alignment
    }
}

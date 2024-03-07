//
//  ViewExtension.swift
//  BoxOffice
//
//  Created by LeeSeongYeon on 2024/03/07.
//

import UIKit

extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution) {
        self.init()
        self.axis = axis
        self.distribution = distribution
    }
}

extension UILabel {
    convenience init(font: UIFont, textAlignment: NSTextAlignment, textColor: UIColor? = nil) {
        self.init()
        self.font = font
        self.textAlignment = textAlignment
        self.textColor = textColor
    }
}

extension UIImageView {
    convenience init(adjustsImageSizeForAccessibilityContentSizeCategory: Bool, contentMode: UIView.ContentMode) {
        self.init()
        self.adjustsImageSizeForAccessibilityContentSizeCategory = adjustsImageSizeForAccessibilityContentSizeCategory
        self.contentMode = contentMode
    }
}

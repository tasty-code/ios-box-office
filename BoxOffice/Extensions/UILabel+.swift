//
//  UILabel+.swift
//  BoxOffice
//
//  Created by Jin-Mac on 3/20/24.
//

import UIKit

extension UILabel {
    
    func setTextColor(_ color: UIColor, range: NSRange) {
        guard let attributedString = self.mutableAttributedString() else { return }
        
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        self.attributedText = attributedString
    }
    
    private func mutableAttributedString() -> NSMutableAttributedString? {
        guard let labelText = self.text, let labelFont = self.font else { return nil }
        
        var attributedString: NSMutableAttributedString?
        if let attributedText = self.attributedText {
            attributedString = attributedText.mutableCopy() as? NSMutableAttributedString
        } else {
            attributedString = NSMutableAttributedString(string: labelText,
                                                         attributes: [NSAttributedString.Key.font :labelFont])
        }
        
        return attributedString
    }
}

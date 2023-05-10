//
//  UILabel+Extension.swift
//  BoxOffice
//
//  Created by Blu on 2023/05/10.
//

import UIKit

extension UILabel {
    
    convenience init(fontSize: UIFont.TextStyle = .body) {
        self.init()
        self.font = .preferredFont(forTextStyle: fontSize)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

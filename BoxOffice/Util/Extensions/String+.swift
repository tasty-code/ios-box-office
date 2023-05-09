//
//  String+.swift
//  BoxOffice
//
//  Created by 김용재 on 2023/05/09.
//

import Foundation

extension String {

    func exceptDash() -> String {
        let dashDeletedString = self.components(separatedBy: ["-"]).joined()

        return dashDeletedString
    }

}

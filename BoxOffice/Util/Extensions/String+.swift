//
//  String+.swift
//  BoxOffice
//
//  Created by 김용재 on 2023/05/09.
//

import Foundation

extension String {

    func except(for characterSet: String) -> String {
        let charSet = CharacterSet(charactersIn: characterSet)
        let dashDeletedString = self.components(separatedBy: charSet).joined()

        return dashDeletedString
    }

}

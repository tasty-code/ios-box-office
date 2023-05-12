//
//  String+.swift
//  BoxOffice
//
//  Created by 김용재 on 2023/05/09.
//

import Foundation

extension String {

    func without(_ characterSet: String) -> String {
        let charSet = CharacterSet(charactersIn: characterSet)
        let trimmedString = self.components(separatedBy: charSet).joined()

        return trimmedString
    }

}

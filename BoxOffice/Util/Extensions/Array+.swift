//
//  Array+.swift
//  BoxOffice
//
//  Created by DONGWOOK SEO on 2023/05/16.
//

import Foundation

extension Array {

    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }

}

extension Array<String> {

    var description: String {
        var description = ""

        for element in self {
            guard description != "" else {
                description = description + element
                continue
            }
            description = description + ", " + element
        }

        guard description != "" else { return Constant.noneText }

        return description
    }

}

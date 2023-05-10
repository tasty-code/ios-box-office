//
//  DecideHelper.swift
//  BoxOffice
//
//  Created by 이상윤 on 2023/05/10.
//

import UIKit

struct DecideHelper: Decidable {
    func determineRankVariation(with rankVariation: String, and rankOldAndNew: RankOldAndNew) -> (String, UIColor) {
        let returnValue = "-"

        switch rankOldAndNew {
        case .new:
            return (MagicLiteral.newMovie, UIColor.red)
        case .old :
            guard rankVariation == MagicLiteral.zero else {
                return (rankVariation, UIColor.black)
            }
            return (returnValue, UIColor.black)
        }
    }

    func determineVariationImage(with rankVariation: String) -> (UIImage, UIColor) {
        guard rankVariation.hasPrefix("-") else {
            return (UIImage(systemName: MagicLiteral.upTriangle) ?? UIImage(), UIColor.red)
        }
        return (UIImage(systemName: MagicLiteral.downTriangle) ?? UIImage(), UIColor.blue)
    }
}

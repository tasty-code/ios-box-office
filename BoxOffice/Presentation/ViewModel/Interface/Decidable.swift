//
//  Decidable.swift
//  BoxOffice
//
//  Created by 이상윤 on 2023/05/10.
//

import UIKit

protocol Decidable {
    func determineRankVariation(with rankVariation: String, and rankOldAndNew: RankOldAndNew) -> String
    func determineRankVariationColor(with rankOldAndNew: RankOldAndNew) -> UIColor
    func determineVariationImage(with rankVariation: String) -> UIImage
    func determineVariationImageColor(with rankVariation: String) -> UIColor
}

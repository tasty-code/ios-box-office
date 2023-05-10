//
//  Decidable.swift
//  BoxOffice
//
//  Created by 이상윤 on 2023/05/10.
//

import UIKit

protocol Decidable {
    func determineRankVariation(with rankVariation: String, and rankOldAndNew: RankOldAndNew) -> (String, UIColor)
    func determineVariationImage(with rankVariation: String) -> (UIImage, UIColor)
}

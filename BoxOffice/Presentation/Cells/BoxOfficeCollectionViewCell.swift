//
//  BoxOfficeCollectionViewCell.swift
//  BoxOffice
//
//  Created by 이상윤 on 2023/05/02.
//

import UIKit

class BoxOfficeCollectionViewCell: UICollectionViewListCell {

    static let cellIdentifier = "BoxOfficeCollectionViewCell"

    let cellStack = UIStackView()
    let rankStack = UIStackView()
    let detailStack = UIStackView()

    let rankLabel = UILabel()
    let rankVariationLabel = UILabel()
    let movieName = UILabel()
    let audienceCount = UILabel()
}

//
//  BoxOfficeListCell.swift
//  BoxOffice
//
//  Created by 이상윤 on 2023/05/02.
//

import UIKit

class BoxOfficeListCell: UICollectionViewListCell {

    static let identifier = String(describing: BoxOfficeListCell.self)

    private let cellStackView: UIStackView = {
        let cellStack = UIStackView()
        
        return cellStack
    }()

}

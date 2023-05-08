//
//  BoxOfficeListCell.swift
//  BoxOffice
//
//  Created by 이상윤 on 2023/05/02.
//

import UIKit

class BoxOfficeListCell: UICollectionViewListCell {

    static let identifier = String(describing: BoxOfficeListCell.self)
    
    private lazy var listContentView = UIListContentView(configuration: defaultListContentConfiguration())

    var dailyBoxOffice: DailyBoxOffice?
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        
    }

    private func defaultListContentConfiguration() -> UIListContentConfiguration {
        return .subtitleCell()
    }
    
}

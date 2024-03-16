//
//  BoxOfficeCollectionViewDelegate.swift
//  BoxOffice
//
//  Created by LeeSeongYeon on 2024/03/12.
//

import Foundation

protocol BoxOfficeCollectionViewDelegate: AnyObject {
    func loadDailyBoxOfficeData() async
}

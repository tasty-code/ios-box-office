//
//  DataDelegate.swift
//  BoxOffice
//
//  Created by LeeSeongYeon on 2024/03/06.
//

protocol DataDelegate: AnyObject {
    func reloadView()
}

protocol LoadDataProtocol {
    associatedtype LoadedData
    var loadedData: [LoadedData] { get }
    func loadData() async throws
}

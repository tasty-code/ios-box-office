//
//  DataDelegate.swift
//  BoxOffice
//
//  Created by LeeSeongYeon on 2024/03/06.
//

protocol DataDelegate: AnyObject {
    func reloadView()
}

protocol BoxOfficeViewControllerDataSource {
    associatedtype LoadedData
    var loadedData: [LoadedData] { get }
    func loadData() async throws
}

protocol MovieInformationViewControllerDataSource {
    associatedtype LoadedData
    var loadedData: LoadedData { get }
    func loadData() async throws
}

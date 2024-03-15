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
    associatedtype BoxOfficeData
    var loadedData: [BoxOfficeData] { get }
    func loadBoxOfficeData() async throws
}

protocol MovieInformationViewControllerDataSource {
    associatedtype MovieInformationData
    var loadedData: MovieInformationData { get }
    func loadMovieInformationData() async throws
}

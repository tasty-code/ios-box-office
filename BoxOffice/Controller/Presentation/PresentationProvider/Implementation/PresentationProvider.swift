//
//  PresentationProvider.swift
//  BoxOffice
//
//  Created by Sunny on 2023/05/15.
//

import Foundation

final class PresentationProvider: PresentationProvidable {
    
    private let boxOfficeDispatcher = BoxOfficeDispatcher()
    private var boxOffices: [BoxOfficeItem] = []
    
    var boxOfficeCall: (() -> Void)?
    
    private var date: String {
        didSet {
            loadBoxOffices(date: date)
        }
    }
    
    init() {
        self.date = Date.yesterday.formatData(type: .network)
        self.loadBoxOffices(date: date)
    }
    
    func loadBoxOffices(date: String) {
        
        let endpoint = DailyBoxOfficeEndpoint(date: date)
        
        Task {
            let networkData = try await boxOfficeDispatcher.fetch(endpoint: endpoint)
            let boxoffices = try await boxOfficeDispatcher.convert(from: networkData)
            self.boxOffices = boxoffices
            
            boxOfficeCall?()
        }
    }
    
    func getBoxOffices() -> [BoxOfficeItem] {
        return self.boxOffices
    }
}

//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class BoxOfficeViewController: UIViewController {
    
    private var dataSource: NetworkDataProtocol? = nil
    private let networkManager: NetworkManager
    
    init(dataSource: BoxOfficeResult? = nil, networkManager: NetworkManager) {
        self.dataSource = dataSource
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
}

extension BoxOfficeViewController {
    private func loadData() {
        Task {
            let type: KoreanFilmCouncilURL = .dailyBoxOffice(queryValue: "20120419")
            guard let request = self.networkManager.makeRequest(type) else {
                return
            }
            let data = await self.networkManager.request(request, into: type) { networkError in
                DispatchQueue.main.async {
                    self.alert(with: networkError)                    
                }
            }
            dataSource = data
        }
    }
}

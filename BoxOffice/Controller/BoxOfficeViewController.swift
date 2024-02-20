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
            guard let request = networkManager.makeRequest(type),
                  let data = await networkManager.request(request, into: type) else {
                return
            }
            dataSource = data
        }
    }
}

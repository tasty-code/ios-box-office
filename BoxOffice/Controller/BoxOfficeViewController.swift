//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class BoxOfficeViewController: UIViewController {
    
    private var dataSource: BoxOfficeResult? = nil
    
    init() {
        super.init(nibName: nil, bundle: nil)
        Task {
            let apiKey: String = Bundle.main.apiKey
            guard let jsonData = await BoxOfficeDTO.requestData(with: KoreanFilmCouncilURLEnumeration.dailyBoxOffice(apiKey, "20240215").url) else {
                return
            }
            dataSource = BoxOfficeDTO.parseJSONData(jsonData)
            print(dataSource)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

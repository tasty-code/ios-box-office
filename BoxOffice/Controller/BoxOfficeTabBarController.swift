//
//  BoxOfficeTabBarController.swift
//  BoxOffice
//
//  Created by LeeSeongYeon on 2024/03/13.
//

import UIKit

class BoxOfficeTabBarController: UITabBarController {
    
    lazy var boxOfficeNavigationController: UINavigationController = {
        let boxOfficeNavigationController = UINavigationController(rootViewController: boxOfficeViewController)
        return boxOfficeNavigationController
    }()
    let boxOfficeViewController: BoxOfficeViewController = BoxOfficeViewController()
    let arSearchTrailerViewController: ARSearchTrailerViewController = ARSearchTrailerViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers([boxOfficeNavigationController, arSearchTrailerViewController], animated: true)
        setTabBar()
    }

    func setTabBar() {
        guard let items = tabBar.items else { return }
        let boxOfficeItem = items[0]
        let trailerSearchItem = items[1]
        
        boxOfficeItem.title = "박스오피스 순위"
        boxOfficeItem.image = UIImage(systemName: "chart.line.uptrend.xyaxis")
        
        trailerSearchItem.title = "트레일러 검색"
        trailerSearchItem.image = UIImage(systemName: "camera.metering.center.weighted")
    }
    
}

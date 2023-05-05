//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class ViewController: UIViewController {

    var networkManager = Networking()

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            let api = URLPath.dailyBoxOffice(date: "20230501")
            let url = try api.configureURL()
            let urlRequest = URLRequest(url: url)

            self.networkManager.loadData(api.convertType, request: urlRequest) { data, error in
                guard error == nil else {
                    print(error as Any)
                    return
                }

                guard let data = data else {
                    print("No Data")
                    return
                }
                print(data)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            let api = URLPath.dailyBoxOffice(date: "20230501")
            let url = try api.configureURL()
            var urlRequest = URLRequest(url: url)

            Networking().loadData(api.convertType, request: urlRequest) { data, error in
                guard error == nil else {
                    print(error)
                    return
                }

                print(data)
            }
        } catch {
            print(error)
        }
    }
}

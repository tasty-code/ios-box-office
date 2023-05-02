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
            let urlRequest = URLRequest(url: url)

            Networking().loadData(api.convertType, request: urlRequest) { data, error in
                guard error == nil else {
                    print(error as Any)
                    return
                }

                guard let data = data else {
                    print("빈 데이터입니다")
                    return
                }
                print(data)
            }
        } catch {
            print(error)
        }
    }
}

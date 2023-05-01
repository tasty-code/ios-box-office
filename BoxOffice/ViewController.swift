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
            let url = try URLPath.movieInformation.configureURL("20231089")
            var urlRequest = URLRequest(url: url)

            Networking().loadData(MovieDetailInformationDTO.self, request: urlRequest) { data, error in
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

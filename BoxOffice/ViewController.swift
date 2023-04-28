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

        Networking().loadData(request: "20230423") { data, error in
            guard error == nil else {
                print(error)
                return
            }

            print(data)
        }
    }
}

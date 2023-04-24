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

        let apiKey = Bundle.main.object(forInfoDictionaryKey: "MOVIE_API_KEY") as? String
        print(apiKey)
    }
}

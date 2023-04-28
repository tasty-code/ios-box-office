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
            print(try URLPath.dailyBoxOffice.configureURL("2012344"))
            print(try URLPath.movieInformation.configureURL("123df"))
        } catch {
            print(error)
        }
    }
}

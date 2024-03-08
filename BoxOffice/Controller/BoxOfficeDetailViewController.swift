//
//  BoxOfficeDetailViewController.swift
//  BoxOffice
//
//  Created by Matthew on 3/8/24.
//

import UIKit

final class BoxOfficeDetailViewController: UIViewController {
    
    let scrollView = BoxOfficeDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = scrollView
        view.backgroundColor = .white
    }
}

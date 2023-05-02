//
//  ViewController.swift
//  BoxOffice
//
//  Created by M&A on 13/01/23.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private let networkManager: NetworkManager
    
    // MARK: - Initialization
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

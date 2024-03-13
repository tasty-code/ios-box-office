//
//  ARSearchTrailerViewController.swift
//  BoxOffice
//
//  Created by Kim EenSung on 3/13/24.
//

import UIKit
import ARKit

class ARSearchTrailerViewController: UIViewController, ARSessionDelegate {
    
    let session: ARSession = ARSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAR()
    }
    
    func loadAR() {
        let configuration = ARImageTrackingConfiguration()
        session.delegate = self
        session.run(configuration)
    }
}

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
    
    let trailerSearchView: ARSCNView = ARSCNView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAR()
    }
    
    override func loadView() {
        view = trailerSearchView
        trailerSearchView.session = session
    }
    
    func loadAR() {
        let configuration = ARImageTrackingConfiguration()
        session.delegate = self
        session.run(configuration)
    }
}

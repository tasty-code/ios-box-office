//
//  ARSearchTrailerViewController.swift
//  BoxOffice
//
//  Created by Kim EenSung on 3/13/24.
//

import UIKit
import ARKit

class ARSearchTrailerViewController: UIViewController, ARSessionDelegate {
    private let session: ARSession = ARSession()
    
    private let configuration: ARImageTrackingConfiguration = ARImageTrackingConfiguration()
    
    private let trailerSearchView: ARSCNView = ARSCNView()
    
    private var referenceImage: Set<ARReferenceImage> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAR()
        Task {
            await loadImage()
        }
    }
    
    override func loadView() {
        view = trailerSearchView
        trailerSearchView.session = session
    }
    
    private func loadAR() {
        session.delegate = self
        session.run(configuration)
    }
    
    private func loadImage() async {
        for imageURL in TrailerImageURL.allCases {
            do {
                guard let url = imageURL.url else { return }
                let (data, _) = try await URLSession.shared.data(from: url)
                guard let image = UIImage(data: data)?.cgImage else {
                    return
                }
                referenceImage.insert(ARReferenceImage(image, orientation: .up, physicalWidth: 0.2))
            } catch {
                print(error)
            }
           
        }
        configuration.trackingImages = referenceImage
        print(referenceImage)
    }
}

extension ARSearchTrailerViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        print("나 잘되니?")
        return SCNNode()
    }
}

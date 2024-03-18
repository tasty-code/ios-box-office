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
        trailerSearchView.delegate = self
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
        session.run(configuration)
    }
}

extension ARSearchTrailerViewController: ARSCNViewDelegate {
    func renderer(_ renderer: any SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let imageAnchor = anchor as? ARImageAnchor {
            let overlayNode = createOverlayNode(for: imageAnchor.referenceImage)
            node.addChildNode(overlayNode)
        }
    }
    
    func createOverlayNode(for referenceImage: ARReferenceImage) -> SCNNode {
        let plane: SCNPlane = SCNPlane(width: referenceImage.physicalSize.width, height: referenceImage.physicalSize.height)
        plane.firstMaterial?.diffuse.contents = UIColor(white: 1, alpha: 0.5)
        
        let overlayNode = SCNNode(geometry: plane)
        overlayNode.eulerAngles.x = -.pi / 2
        
//        let overlayNode = SCNNode(geometry: SCNPlane(width: referenceImage.physicalSize.width,
//                                                      height: referenceImage.physicalSize.height))
//        overlayNode.geometry?.firstMaterial?.diffuse.contents = UIColor(white: 1, alpha: 0.5) // 예시: 반투명 흰색
//        overlayNode.eulerAngles.x = -.pi / 2 // 평면을 수평으로 회전

        return overlayNode
    }
}

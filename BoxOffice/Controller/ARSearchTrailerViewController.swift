//
//  ARSearchTrailerViewController.swift
//  BoxOffice
//
//  Created by Kim EenSung on 3/13/24.
//

import UIKit
import ARKit
import AVKit

class ARSearchTrailerViewController: UIViewController, ARSessionDelegate {
    private lazy var session: ARSession = {
        let session = ARSession()
        session.delegate = self
        session.run(configuration)
        return session
    }()
    private let configuration: ARImageTrackingConfiguration = ARImageTrackingConfiguration()
    private var referenceImage: Set<ARReferenceImage> = []
    
    private lazy var trailerSearchView: ARSCNView = {
        let trailerSearchView = ARSCNView()
        trailerSearchView.delegate = self
        return trailerSearchView
    }()
    
    private lazy var avPlayerViewController: AVPlayerViewController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await loadImage()
        }
        addGesture()
    }
    
    override func loadView() {
        view = trailerSearchView
        trailerSearchView.session = session
    }
}

extension ARSearchTrailerViewController {
    private func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.trailerSearchView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        let location = gestureRecognize.location(in: trailerSearchView)
        let hitResults = trailerSearchView.hitTest(location, options: [:])
        if let firstHit = hitResults.first {
            let node = firstHit.node
            guard let trailerName = node.name,
                  let trailer = TrailerURL(rawValue: trailerName),
                  let url = trailer.videoURL else {
                return
            }
            
            avPlayerViewController.player = AVPlayer(url: url)
            avPlayerViewController.player?.play()
            present(avPlayerViewController, animated: true)
        }
    }
    
    private func loadImage() async {
        for trailer in TrailerURL.allCases {
            do {
                guard let url = trailer.imageURL else { return }
                
                let (data, _) = try await URLSession.shared.data(from: url)
                
                guard let image = UIImage(data: data)?.cgImage else { return }
                
                let referenceImage = ARReferenceImage(image, orientation: .up, physicalWidth: 0.2)
                referenceImage.name = trailer.rawValue
                self.referenceImage.insert(referenceImage)
                
            } catch {
                print(error)
            }
        }
        
        configuration.trackingImages = referenceImage
        configuration.maximumNumberOfTrackedImages = 3
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
    
    private func createOverlayNode(for referenceImage: ARReferenceImage) -> SCNNode {
        let plane: SCNPlane = SCNPlane(width: referenceImage.physicalSize.width, height: referenceImage.physicalSize.height)
        
        let overlayNode = SCNNode(geometry: plane)
        overlayNode.name = referenceImage.name
        overlayNode.eulerAngles.x = -.pi / 2
        overlayNode.opacity = 0.25
        
        return overlayNode
    }
}

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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.trailerSearchView.addGestureRecognizer(tapGesture)
    }
    
    override func loadView() {
        view = trailerSearchView
        trailerSearchView.session = session
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
            
            let avPlayer: AVPlayerViewController = AVPlayerViewController()
            avPlayer.player = AVPlayer(url: url)
            avPlayer.player?.play()
            present(avPlayer, animated: true)
        }
    }

    
    private func loadAR() {
        session.delegate = self
        session.run(configuration)
    }
    
    private func loadImage() async {
        for trailer in TrailerURL.allCases {
            do {
                guard let url = trailer.imageURL else { return }
                let (data, _) = try await URLSession.shared.data(from: url)
                guard let image = UIImage(data: data)?.cgImage else {
                    return
                }
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
    
    func createOverlayNode(for referenceImage: ARReferenceImage) -> SCNNode {
        let plane: SCNPlane = SCNPlane(width: referenceImage.physicalSize.width, height: referenceImage.physicalSize.height)
        
        let overlayNode = SCNNode(geometry: plane)
        overlayNode.name = referenceImage.name
        overlayNode.eulerAngles.x = -.pi / 2
        overlayNode.opacity = 0.25
        
        return overlayNode
    }
}

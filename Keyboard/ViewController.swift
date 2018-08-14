//
//  ViewController.swift
//  Keyboard
//
//  Created by caopengxu on 2018/8/13.
//  Copyright © 2018年 caopengxu. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
//import SpriteKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var scene: SCNScene!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        
        sceneView.showsStatistics = true
        
        scene = SCNScene(named: "art.scnassets/GameScene.scn")!
        
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARImageTrackingConfiguration()
        guard let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "Images", bundle: Bundle.main) else {
            return
        }
        configuration.trackingImages = trackedImages
        configuration.maximumNumberOfTrackedImages = 2
//        configuration.worldAlignment = .gravityAndHeading
        configuration.worldAlignment = .camera
        
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    
    
    // MARK: === RSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode?
    {
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor
        {
            print(imageAnchor.transform)
            
            if (imageAnchor.name == "mouse")
            {
                let nikename = SCNText(string: "这是一个鼠标", extrusionDepth: 0.01)
                nikename.firstMaterial?.diffuse.contents = UIColor.red
                nikename.font = UIFont(name: "BradleyHandITCTT-Bold", size: 0.2)
                
//                let a = imageAnchor.transform.columns
//                let b = imageAnchor.transform.debugDescription
//                let c = imageAnchor.transform.determinant
//                let d = imageAnchor.transform.inverse
//                let e = imageAnchor.transform.transpose
                
                let nikenameNode = SCNNode(geometry: nikename)
                let mat = SCNMatrix4(imageAnchor.transform)
                
                
                let dir = SCNVector3(1 * mat.m31, 1 * mat.m32, 1 * mat.m33)
                let pos = SCNVector3(mat.m41, mat.m42, mat.m43)
//                nikenameNode.transform = SCNMatrix4(imageAnchor.transform)
//                nikenameNode.transform = SCNMatrix4MakeRotation(-.pi / 2, 1, 0, 0)
                print(dir)
                
                nikenameNode.rotation = SCNVector4(1, 0, 0, -Float.pi / 2)
//                nikenameNode.position = SCNVector3(0, 0, 0)
                nikenameNode.position = pos
               
                scene.rootNode.addChildNode(nikenameNode)
                
//                node.addChildNode(nikenameNode)
            }
            else
            {
                let password = SCNText(string: "这是一片纸巾这是一片纸巾这是一片纸巾这是一片纸巾这是一片纸巾", extrusionDepth: 0.1)
                password.firstMaterial?.diffuse.contents = UIColor.red
                password.font = UIFont(name: "BradleyHandITCTT-Bold", size: 0.5)
                let passwordNode = SCNNode(geometry: password)
                
                passwordNode.transform = SCNMatrix4MakeRotation(-.pi / 2, 1, 0, 0)
                
                node.addChildNode(passwordNode)
            }
        }
        
        return node
    }
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval)
    {
//        print(time)
    }
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor)
    {
        print(node)
        print(anchor)
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

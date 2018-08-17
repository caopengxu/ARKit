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

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var scene: SCNScene!
    var once = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.showsStatistics = true
        scene = SCNScene(named: "art.scnassets/GameScene.scn")!
        sceneView.scene = scene
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
//        let configuration = ARImageTrackingConfiguration()
        guard let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "Images", bundle: Bundle.main) else {
            return
        }
//        configuration.trackingImages = trackedImages
//        configuration.maximumNumberOfTrackedImages = 2
        
        configuration.detectionImages = trackedImages
        configuration.maximumNumberOfTrackedImages = 2
        
        configuration.worldAlignment = .gravityAndHeading
//        configuration.worldAlignment = .camera
        
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    
    
    // MARK: === RSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval)
    {
    }
    func renderer(_ renderer: SCNSceneRenderer, willUpdate node: SCNNode, for anchor: ARAnchor)
    {
    }
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor)
    {
    }
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode?
    {
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor
        {
            let w = Float(imageAnchor.referenceImage.physicalSize.width)
            let h = Float(imageAnchor.referenceImage.physicalSize.height)
            
            
            let mat = SCNMatrix4(anchor.transform)
            let dir = SCNVector3(-1 * mat.m31, -1 * mat.m32, -1 * mat.m33)
            let pos = SCNVector3(mat.m41, mat.m42, mat.m43)
            
//            var offset = matrix_identity_float4x4
//            offset.columns.3.z = 0.2
//            let transform = simd_mul(anchor.transform, offset)
            
            
            let text1 = SCNText(string: "这是个鼠标", extrusionDepth: 0.01)
            text1.firstMaterial?.diffuse.contents = UIImage(named: "1.jpg")
            text1.font = UIFont(name: "BradleyHandITCTT-Bold", size: 0.01)
            let textNode1 = SCNNode(geometry: text1)
            textNode1.transform = mat
//            textNode1.position = SCNVector3(0, 0, 0)
            
            let text2 = SCNText(string: "这个是个logo", extrusionDepth: 0.1)
            text2.firstMaterial?.diffuse.contents = UIImage(named: "1.jpg")
            text2.font = UIFont(name: "BradleyHandITCTT-Bold", size: 0.1)
            let textNode2 = SCNNode(geometry: text2)
            textNode2.transform = mat
//            textNode2.position = SCNVector3(-w / 2, -h / 2, pos.z)
            
            let text3 = SCNText(string: "看右边", extrusionDepth: 0.1)
            text3.firstMaterial?.diffuse.contents = UIImage(named: "1.jpg")
            text3.font = UIFont(name: "BradleyHandITCTT-Bold", size: 0.1)
            let textNode3 = SCNNode(geometry: text3)
            textNode3.transform = mat
//            textNode3.position = SCNVector3(-w, -h, pos.z)
            
            
            let moon = SCNSphere(radius: 0.005)
            moon.firstMaterial?.diffuse.contents = UIImage(named: "2.jpg")
            let moonNode = SCNNode(geometry: moon)
            moonNode.position = SCNVector3(0, 0, 0)
            
            let earth = SCNSphere(radius: 0.01)
            earth.firstMaterial?.diffuse.contents = UIImage(named: "3.jpg")
            let earthNode = SCNNode(geometry: earth)
            earthNode.position = SCNVector3(w / 2, 0, 0)
            
            let sphere = SCNSphere(radius: 0.03)
            sphere.firstMaterial?.diffuse.contents = UIImage(named: "1.jpg")
            let sphereNode = SCNNode(geometry: sphere)
            sphereNode.position = SCNVector3(w, 0, 0)
            
//            node.addChildNode(textNode1)
//            node.addChildNode(textNode2)
//            node.addChildNode(textNode3)
            node.addChildNode(moonNode)
            node.addChildNode(earthNode)
            node.addChildNode(sphereNode)
        }
        return node
    }
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor)
    {
    }
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor)
    {
    }
}

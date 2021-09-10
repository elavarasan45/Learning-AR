//
//  ViewController.swift
//  LearningAR
//
//  Created by raja on 09/09/21.
//

import UIKit
import RealityKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        addSquareMesh()
    }
    
    func addSphere()  {
        //1.create 3D Model
        let sphere = MeshResource.generateSphere(radius: 0.05)
        let material = SimpleMaterial(color: .red, roughness: 0, isMetallic: true)
        
        let sphereEntity : ModelEntity = ModelEntity(mesh: sphere, materials: [material])
        
        
        //2.Create Anchor
        
        let sphereAnchor = AnchorEntity(world: SIMD3(x: 0, y: 0, z: 0))
        sphereAnchor.addChild(sphereEntity)
        
        
        //3. Add Anchor
        
        arView.scene.addAnchor(sphereAnchor)
    }
    
    func addSquareMesh() {
        let anchor = AnchorEntity(plane: .horizontal, minimumBounds: [0.2,0.2])
        
        
        var cards : [Entity] = []
        for _ in 1...4 {
            let box = MeshResource.generateBox(width: 0.4, height: 0.002, depth: 0.04)
            let metalMaterial = SimpleMaterial(color: .gray, isMetallic: true)
            let model = ModelEntity(mesh: box, materials: [metalMaterial])
            
            model.generateCollisionShapes(recursive: true)
        
            cards.append(model)
        
        }
        
        for(index , card) in cards.enumerated(){
            let x = Float(index % 2)
            let z = Float(index / 2)
            card.position = [x * 0.1 ,0 ,z * 0.1 ];
            anchor.addChild(card)
    
        }
        
        arView.scene.addAnchor(anchor)
    }
    
    
    

    
}

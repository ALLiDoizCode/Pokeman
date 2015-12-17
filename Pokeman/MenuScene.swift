//
//  MenuScene.swift
//  Pokeman
//
//  Created by Jonathan Green on 12/17/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SpriteKit

class MenuScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        
        setupTransiton()
    }
    
    func setupTransiton() {
        let scene:GameScene = GameScene(size: view!.bounds.size)
        let theTransition:SKTransition = SKTransition.fadeWithDuration(0.10)
        view?.presentScene(scene, transition: theTransition)
    }
}

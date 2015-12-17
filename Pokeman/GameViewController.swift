//
//  GameViewController.swift
//  Pokeman
//
//  Created by Jonathan Green on 11/30/15.
//  Copyright (c) 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    @IBOutlet weak var start: UIButton!
    @IBOutlet weak var credits: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    @IBAction func startBtn(sender: AnyObject) {
        
        if let scene = GameScene(fileNamed:"GameScene") {
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .AspectFill
        let theTransition:SKTransition = SKTransition.fadeWithDuration(0.10)
        skView.presentScene(scene, transition: theTransition)
            
            start.hidden = true
            credits.hidden = true
        }
   
    }
   
    @IBAction func creditBtn(sender: AnyObject) {
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

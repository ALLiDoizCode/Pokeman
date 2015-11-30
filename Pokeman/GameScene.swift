//
//  GameScene.swift
//  Pokeman
//
//  Created by Jonathan Green on 11/30/15.
//  Copyright (c) 2015 Jonathan Green. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene {
    
    let myNumber:Int = 10
    let gameName:String = "Pokeman"
    var malePlayer:SKSpriteNode = SKSpriteNode()
    
    let tapRect = UITapGestureRecognizer()

    override func didMoveToView(view: SKView) {
        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
    
        if let theSpriteNode:SKSpriteNode = self.childNodeWithName("MaleSprite") as? SKSpriteNode {
            
            malePlayer = theSpriteNode
        }
        
        tapRect.addTarget(self, action: "tappedView:")
        tapRect.numberOfTapsRequired = 1
        tapRect.numberOfTouchesRequired = 1
        self.view!.addGestureRecognizer(tapRect)
        
       
    }
    
    
    func tappedView(sender:UITapGestureRecognizer){
        
        var playSound:AVAudioPlayer = AVAudioPlayer()
        
        let SoundEffect:NSURL = NSBundle.mainBundle().URLForResource("Walking", withExtension: "mp3")!
        do { playSound = try AVAudioPlayer(contentsOfURL: SoundEffect, fileTypeHint: nil) } catch _ { return print("file not found") }
            playSound.numberOfLoops = 1
            playSound.prepareToPlay()
            playSound.play()
        
        var touchLocation:CGPoint = sender.locationInView(self.view!)
        touchLocation = self.convertPointFromView(touchLocation)
        
        let move:SKAction = SKAction.moveTo(touchLocation, duration: 0.6)
        move.timingMode = .EaseOut
        
       
        
        print("tapped")
        
        malePlayer.runAction(move) { () -> Void in
            
            playSound.stop()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

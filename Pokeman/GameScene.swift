//
//  GameScene.swift
//  Pokeman
//
//  Created by Jonathan Green on 11/30/15.
//  Copyright (c) 2015 Jonathan Green. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    let myNumber:Int = 10
    let gameName:String = "Pokeman"
    var malePlayer:SKSpriteNode = SKSpriteNode()
    var scoreLabel:SKLabelNode = SKLabelNode()
    var gameOverLabel:SKLabelNode = SKLabelNode()
    var life = 5
    
    let tapRect = UITapGestureRecognizer()

    override func didMoveToView(view: SKView) {
        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        
        self.physicsWorld.contactDelegate = self
    
        if let theSpriteNode:SKSpriteNode = self.childNodeWithName("MaleSprite") as? SKSpriteNode {
            
            malePlayer = theSpriteNode
        }
        
        if let theLabelNode:SKLabelNode = self.childNodeWithName("score") as? SKLabelNode {
            
            scoreLabel = theLabelNode
            scoreLabel.text = "\(life)"
        }
        
        if let theLabelNode:SKLabelNode = self.childNodeWithName("GameOver") as? SKLabelNode {
            
            gameOverLabel = theLabelNode
            gameOverLabel.hidden = true
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
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        
        /*var playSound:AVAudioPlayer = AVAudioPlayer()
        
        
        let SoundEffect:NSURL = NSBundle.mainBundle().URLForResource("hit", withExtension: "mp3")!
        do { playSound = try AVAudioPlayer(contentsOfURL: SoundEffect, fileTypeHint: nil) } catch _ { return print("file not found") }
        playSound.numberOfLoops = 1
        playSound.prepareToPlay()
        playSound.play()*/

        
        if contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 2 {
            
            print("hit")
            
            let soundEffect:SKAction = SKAction.playSoundFileNamed("hit.mp3", waitForCompletion: false)
            let gameOverSound:SKAction = SKAction.playSoundFileNamed("GameOver.mp3", waitForCompletion: false)
            
            malePlayer.runAction(soundEffect)
            
            life = life - 1
            
            scoreLabel.text = "\(life)"
            
            if life < 1 {
                
                scoreLabel.text = "You are Dead"
                
                self.view?.removeGestureRecognizer(tapRect)
                
                malePlayer.hidden = true
                gameOverLabel.hidden = false
                gameOverLabel.runAction((gameOverSound), completion: { () -> Void in
                    
                    self.gameOverLabel.removeAllActions()
                
                })
                
            }
            
            }else if contact.bodyA.categoryBitMask == 2 && contact.bodyB.categoryBitMask == 1  {
            
            print("hit")
            
            
        }
        
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

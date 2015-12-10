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
    var grass:SKSpriteNode = SKSpriteNode()
    var scoreLabel:SKLabelNode = SKLabelNode()
    var gameOverLabel:SKLabelNode = SKLabelNode()
    var life = 5
    
    
    let tapRect = UITapGestureRecognizer()

    override func didMoveToView(view: SKView) {
        
        makeGrass()
        
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
    
    func makeGrass() {
        
        let grassCount = 6
        let count = 11
        var ogPosition = CGPoint(x: 460, y: 90)
        var position = CGPoint(x: 460, y: 90)

        for var i = 0; i < grassCount; i++ {
            
            for var j = 0; j < count; j++ {
                
                grass = SKSpriteNode(imageNamed: "8")
                grass.position = position
                position = CGPoint(x: position.x, y: position.y + 60)
                addChild(grass)
            }
            
            position = CGPoint(x: position.x + 50, y: ogPosition.y)

        }
        
    }
    
    
    func tappedView(sender:UITapGestureRecognizer){
        
        var playSound:AVAudioPlayer = AVAudioPlayer()
        var scaleDirection:CGFloat!
        var walk:SKAction!
        
        let SoundEffect:NSURL = NSBundle.mainBundle().URLForResource("Walking", withExtension: "mp3")!
        do { playSound = try AVAudioPlayer(contentsOfURL: SoundEffect, fileTypeHint: nil) } catch _ { return print("file not found") }
            playSound.numberOfLoops = 1
            playSound.prepareToPlay()
            playSound.play()
        
        var touchLocation:CGPoint = sender.locationInView(self.view!)
        touchLocation = self.convertPointFromView(touchLocation)
        
        
        let moveRight:SKAction = SKAction.moveToX(malePlayer.position.x + 200, duration: 1.0)
        let moveLeft:SKAction = SKAction.moveToX(malePlayer.position.x - 200, duration: 1.0)
        let moveUp:SKAction = SKAction.moveToY(malePlayer.position.y + 200, duration: 1.0)
        let moveDown:SKAction = SKAction.moveToY(malePlayer.position.y - 200, duration: 1.0)
        moveRight.timingMode = .EaseOut
        moveLeft.timingMode = .EaseOut
        moveUp.timingMode = .EaseOut
        moveDown.timingMode = .EaseOut
        
        // go left
        if touchLocation.x <= CGRectGetMidX(malePlayer.frame) && (touchLocation.y <= malePlayer.frame.origin.y + 100 &&  touchLocation.y >= malePlayer.frame.origin.y - 100) {
            
            scaleDirection = 1.0
            walk = SKAction(named: "left")!
            print("tapped")
            
            malePlayer.runAction(walk)
            
            malePlayer.runAction(moveLeft) { () -> Void in
                
                playSound.stop()
                walk = SKAction.stop()
                self.malePlayer.texture = SKTexture(imageNamed: "WalkingLeft69")
                
            }
            
            
            //go right
        }else if touchLocation.x >= CGRectGetMidX(malePlayer.frame) && (touchLocation.y <= malePlayer.frame.origin.y + 100 &&  touchLocation.y >= malePlayer.frame.origin.y - 100) {
            
            scaleDirection = -1.0
            walk = SKAction(named: "walk")!
            print("tapped")
            
            malePlayer.runAction(walk)
            
            malePlayer.runAction(moveRight) { () -> Void in
                
                playSound.stop()
                walk = SKAction.stop()
                self.malePlayer.texture = SKTexture(imageNamed: "WalkingRight87")
                
            }
            
           
            // go up
        }else if touchLocation.y >= CGRectGetMidY(malePlayer.frame) && (touchLocation.x >= CGRectGetMidX(malePlayer.frame) || touchLocation.x <= CGRectGetMidX(malePlayer.frame)) {
            
            scaleDirection = 1.0
            walk = SKAction(named: "up")!
            print("tapped")
            
            malePlayer.runAction(walk)
            
            malePlayer.runAction(moveUp) { () -> Void in
                
                playSound.stop()
                walk = SKAction.stop()
                self.malePlayer.texture = SKTexture(imageNamed: "WalkingUp61")
                
            }
            
            // go down
        }else if touchLocation.y <= CGRectGetMidY(malePlayer.frame) {
            scaleDirection = -1.0
            walk = SKAction(named: "down")!
            print("tapped")
            
            malePlayer.runAction(walk)
            
            malePlayer.runAction(moveDown) { () -> Void in
                
                playSound.stop()
                walk = SKAction.stop()
                self.malePlayer.texture = SKTexture(imageNamed: "WalkingDown78")
                
            }
            
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

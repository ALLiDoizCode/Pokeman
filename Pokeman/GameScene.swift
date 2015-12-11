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
    var bg:SKSpriteNode = SKSpriteNode()
    var gameOverLabel:SKLabelNode = SKLabelNode()
    var life = 5
    
    var battle : AVAudioPlayer?
    var walking : AVAudioPlayer?
    var endMusic : AVAudioPlayer?
    
    
    let tapRect = UITapGestureRecognizer()

    override func didMoveToView(view: SKView) {
        
        makeGrass()
        
        if let battle = self.setupAudioPlayerWithFile("battle", type:"mp3") {
            self.battle = battle
        }
        if let walking = self.setupAudioPlayerWithFile("Walking", type:"mp3") {
            self.walking = walking
        }
        if let endMusic = self.setupAudioPlayerWithFile("GameOver", type:"mp3") {
            self.endMusic = endMusic
        }
        
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
        
        if let theLabelNode:SKSpriteNode = self.childNodeWithName("bg") as? SKSpriteNode {
            
            bg = theLabelNode
            bg.color = UIColor.clearColor()
            
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
                grass.physicsBody = SKPhysicsBody(rectangleOfSize: grass.size)
                grass.physicsBody?.dynamic = true
                grass.physicsBody?.categoryBitMask = 3
                
                grass.physicsBody?.collisionBitMask = 0
                grass.physicsBody?.affectedByGravity = false
                grass.physicsBody?.pinned = true
                grass.position = position
                grass.blendMode = .Screen
                grass.colorBlendFactor = 0.45
                
                position = CGPoint(x: position.x, y: position.y + 60)
                addChild(grass)
            }
            
            position = CGPoint(x: position.x + 50, y: ogPosition.y)

        }
        
    }
    
    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer?  {
        
        let path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        let url = NSURL.fileURLWithPath(path!)
        
        
        var audioPlayer:AVAudioPlayer?
        
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: url)
        } catch {
            print("Player not available")
        }
        
        return audioPlayer
    }
    
    
    func tappedView(sender:UITapGestureRecognizer){
        
        var scaleDirection:CGFloat!
        var walk:SKAction!
        
        walking?.play()
        
        var touchLocation:CGPoint = sender.locationInView(self.view!)
        touchLocation = self.convertPointFromView(touchLocation)
        
        
        let moveRight:SKAction = SKAction.moveToX(malePlayer.position.x + 150, duration: 1.0)
        let moveLeft:SKAction = SKAction.moveToX(malePlayer.position.x - 150, duration: 1.0)
        let moveUp:SKAction = SKAction.moveToY(malePlayer.position.y + 150, duration: 1.0)
        let moveDown:SKAction = SKAction.moveToY(malePlayer.position.y - 150, duration: 1.0)
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
                
                self.walking!.stop()
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
                
                self.walking!.stop()
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
                
                self.walking!.stop()
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
                
                self.walking!.stop()
                walk = SKAction.stop()
                self.malePlayer.texture = SKTexture(imageNamed: "WalkingDown78")
                
            }
            
        }
    
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        let soundEffect:SKAction = SKAction.playSoundFileNamed("hit.mp3", waitForCompletion: false)
        let delay:SKAction = SKAction.waitForDuration(0.2)
        let flashBlack:SKAction = SKAction.runBlock { () -> Void in
            
            self.bg.color = UIColor.blackColor()
        }
        
        let flashClear:SKAction = SKAction.runBlock { () -> Void in
            
            self.bg.color = UIColor.clearColor()
        }
        
        
        
        if contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 2 {
            
            print("hit")
            
            malePlayer.runAction(soundEffect)
            
            life = life - 1
            
            scoreLabel.text = "\(life)"
            
            if life < 1 {
                
                scoreLabel.text = "You are Dead"
                
                self.view?.removeGestureRecognizer(tapRect)
                
                malePlayer.hidden = true
                gameOverLabel.hidden = false
                endMusic?.play()
                
                bg.runAction(SKAction.repeatActionForever(SKAction.sequence([delay,flashBlack,delay,flashClear])))
                
            }
            
            }else if contact.bodyA.categoryBitMask == 2 && contact.bodyB.categoryBitMask == 1  {
            
            print("hit")
            
            
        }
        
        if contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 3 {
            
            let random = Int(arc4random_uniform(50))
            
            if random == 1 {
                
                battle?.play()
                print("grass")
                self.malePlayer.removeActionForKey("soundEffect")
                self.malePlayer.removeActionForKey("walk")
                self.view?.removeGestureRecognizer(tapRect)
                
                bg.runAction(SKAction.repeatActionForever(SKAction.sequence([delay,flashBlack,delay,flashClear])))
            }
            
           
            
            if ((battle?.playing) != nil)  {
                
                print("first")
                
            }else{
                
                
            }
            
        }else if contact.bodyA.categoryBitMask == 3 && contact.bodyB.categoryBitMask == 1 {
            
            let random = Int(arc4random_uniform(50))
          
            if random == 1 {
                
                battle?.play()
                print("grass")
                self.malePlayer.removeActionForKey("soundEffect")
                self.malePlayer.removeActionForKey("walk")
                self.view?.removeGestureRecognizer(tapRect)
            }
            
            if ((battle?.playing) != nil)  {
                
                print("second")
                
            }else{
                
               
            }
            
        }
        
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

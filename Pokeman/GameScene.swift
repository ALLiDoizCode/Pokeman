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
    var life = 5
    
    //Sprites
    var malePlayer:SKSpriteNode = SKSpriteNode()
    var grass:SKSpriteNode = SKSpriteNode()
    var scoreLabel:SKLabelNode = SKLabelNode()
    var bg:SKSpriteNode = SKSpriteNode()
    var pause:SKSpriteNode = SKSpriteNode()
    var gameOverLabel:SKLabelNode = SKLabelNode()
  
    
    //Sounds
    var battle : AVAudioPlayer?
    var walking : AVAudioPlayer?
    var endMusic : AVAudioPlayer?
    
    
    let tapRect = UITapGestureRecognizer()

    override func didMoveToView(view: SKView) {
        
        makeGrass()
        
        //asigns sounds to audioplayer
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
        
        
        //asigns sprite sheets to skspritenodes
        if let theSpriteNode:SKSpriteNode = self.childNodeWithName("MaleSprite") as? SKSpriteNode {
            
            malePlayer = theSpriteNode
            
        }
        
        if let theLabelNode:SKLabelNode = self.childNodeWithName("score") as? SKLabelNode {
            
            scoreLabel = theLabelNode
            scoreLabel.text = "\(life)"
        }
        
        if let theSpriteNode:SKLabelNode = self.childNodeWithName("GameOver") as? SKLabelNode {
            
            gameOverLabel = theSpriteNode
            gameOverLabel.hidden = true
        }
        
        if let theSpriteNode:SKSpriteNode = self.childNodeWithName("pause") as? SKSpriteNode {
            
            pause = theSpriteNode
           
        }
        
        
        if let theLabelNode:SKSpriteNode = self.childNodeWithName("bg") as? SKSpriteNode {
            
            bg = theLabelNode
            bg.color = UIColor.clearColor()
            
        }
        
        //creates tap gesture and adds it to the scene
        tapRect.addTarget(self, action: "tappedView:")
        tapRect.numberOfTapsRequired = 1
        tapRect.numberOfTouchesRequired = 1
        self.view!.addGestureRecognizer(tapRect)
        
       
    }
    
    //programically creates rows of grass
    func makeGrass() {
        
        let grassCount = 6
        let count = 11
        let ogPosition = CGPoint(x: 460, y: 90)
        var position = CGPoint(x: 460, y: 90)
        
        //this loop creates rows of grass  horizontaly
        for var i = 0; i < grassCount; i++ {
            
            //this loop creates row vertically
            for var j = 0; j < count; j++ {
                
                grass = SKSpriteNode(imageNamed: "8")
                grass.physicsBody = SKPhysicsBody(rectangleOfSize: grass.size)
                grass.physicsBody?.dynamic = true
                grass.physicsBody?.categoryBitMask = 3
                grass.physicsBody?.collisionBitMask = 2
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
    
    
    //func that returns audio player for each sound
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
    
    
    // recieves user tap from scene and runs configuration
    func tappedView(sender:UITapGestureRecognizer){
        
        var walk:SKAction!
        
        
        //checks is scene is paused
        if self.view?.paused == true {
            
        }else {
            
            walking?.play()
        }
        
        
        
        var touchLocation:CGPoint = sender.locationInView(self.view!)
        touchLocation = self.convertPointFromView(touchLocation)
        
        //setups up malesprite movent disntace direction and duration
        let moveRight:SKAction = SKAction.moveToX(malePlayer.position.x + 120, duration: 1.0)
        let moveLeft:SKAction = SKAction.moveToX(malePlayer.position.x - 120, duration: 1.0)
        let moveUp:SKAction = SKAction.moveToY(malePlayer.position.y + 120, duration: 1.0)
        let moveDown:SKAction = SKAction.moveToY(malePlayer.position.y - 120, duration: 1.0)
        moveRight.timingMode = .EaseOut
        moveLeft.timingMode = .EaseOut
        moveUp.timingMode = .EaseOut
        moveDown.timingMode = .EaseOut
        
        // go left
        if touchLocation.x <= CGRectGetMidX(malePlayer.frame) && (touchLocation.y <= malePlayer.frame.origin.y + 100 &&  touchLocation.y >= malePlayer.frame.origin.y - 100) {
            
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
    
    
    // configures actions based on physics contants
    func didBeginContact(contact: SKPhysicsContact) {
        
        //setups up skactions
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
            
            //checks current life count then takes of 1 life or ends game
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
            
            //if maleplayer has contact with grass setups a random number genrator 1 - 469 it number is 1 runs encouter
            
            let random = Int(arc4random_uniform(470))
            
            if random == 1 {
                
                battle?.play()
                print("grass")
                self.malePlayer.removeActionForKey("soundEffect")
                self.malePlayer.removeActionForKey("walk")
                self.view?.removeGestureRecognizer(tapRect)
                
                bg.runAction(SKAction.repeatActionForever(SKAction.sequence([delay,flashBlack,delay,flashClear])))
            }
            
            //if maleplayer has contact with grass setups a random number genrator 1 - 469 it number is 1 runs encouter
        }else if contact.bodyA.categoryBitMask == 3 && contact.bodyB.categoryBitMask == 1 {
            
            let random = Int(arc4random_uniform(470))
          
            if random == 1 {
                
                battle?.play()
                print("grass")
                self.malePlayer.removeActionForKey("soundEffect")
                self.malePlayer.removeActionForKey("walk")
                self.view?.removeGestureRecognizer(tapRect)
            }
            
        }
        
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            // Gets the location of touch in  scene
            let location = touch.locationInNode(self)
            // Checks if touch is within the button's bounds
            if pause.containsPoint(location) {
                print("tapped")
                
                //checks if view is scene is paused
                if self.view?.paused == true {
                    
                    self.view?.paused = false
                    
                }else {
                    
                    //stops sounds when pause
                        battle?.stop()
                        walking?.stop()
                        endMusic?.stop()
                        
                        self.view?.paused = true
                
                }
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

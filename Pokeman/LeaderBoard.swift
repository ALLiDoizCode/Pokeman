//
//  LeaderBoard.swift
//  Pokeman
//
//  Created by Jonathan Green on 2/20/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import Parse


class LeaderBoard {
    
    let board = PFObject(className: "LeaderBoard")
    
    let currentUser = PFUser.currentUser()
    
    func addScore(score:Int){
        
        board["Score"] = score
        board["Name"] = currentUser
        
        board.saveEventually { (success, error) -> Void in
        
            if success {
                
                let relation = self.currentUser?.relationForKey("Scores")
                
                relation?.addObject(self.board)
            }
        }
    }
    
    func getScores(user:Bool,completion:(scores:[Score]) -> Void){
        
        let queryBoard = PFUser.query()
        
        var score:[Score] = []
        
        if user {
            
            
            let relation = currentUser!.relationForKey("Scores")
            
            let query = relation.query()
            
            query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                
                if let objects = objects {
                    
                    for object in objects {
                        
                        let userScore = object.objectForKey("Score") as! Int
                        let user = object.objectForKey("Name") as! PFUser
                        let name = user.username
                        
                        let myScores = Score(theScore: userScore, theName: name!)
                        
                        print(userScore)
                        print(name)
                        
                        score.append(myScores)
                    }
                    
                    completion(scores: score)
                }
            })
            
        }else {
            
            queryBoard!.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
                
                if error == nil {
                    
                    print(objects?.count)
                    
                    for object in objects! {
                        
                        let relation = object.relationForKey("Scores")
                        
                        let query = relation.query()
                        
                        query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                            
                            if let objects = objects {
                                
                                for object in objects {
                                    
                                    let userScore = object.objectForKey("Score") as! Int
                                    let user = object.objectForKey("Name") as! PFUser
                                    let name = user.username
                                    
                                    let myScores = Score(theScore: userScore, theName: name!)
                                    
                                    print(userScore)
                                    print(name)
                                    
                                    score.append(myScores)
                                }
                                
                                completion(scores: score)
                            }
                        })
                    }
                    
                    
                }else {
                    
                    print(error)
                }
                
                
            }
        }
        
        
    }
    
    func signin(userName:String,pass:String,completion:(success:Bool) -> Void){
        
        PFUser.logInWithUsernameInBackground(userName, password:pass) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
                
                completion(success: true)
            } else {
                // The login failed. Check error to see why.
                completion(success: false)
            }
        }
    }
    
    func signOut(){
        
        PFUser.logOut()
    }
    
    func signUp(userName:String,pass:String,email:String,completion:(success:Bool) -> Void){
        
        let user = PFUser()
        user.username = userName
        user.password = pass
        user.email = email
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
                
                completion(success: false)
            } else {
                // Hooray! Let them use the app now.
                print("signup success")
                
                completion(success: true)
            }
        }
    }
}

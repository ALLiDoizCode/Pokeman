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
    
    //let currentUser = PFUser.currentUser()
    
    func addScore(score:Int){
        
        board["Score"] = score
    }
    
    func getScores(completion:(scores:[Score]) -> Void){
        
        let queryBoard = PFUser.query()
        
        var score:[Score] = []

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
    
    func signin(userName:String,pass:String){
        
        PFUser.logInWithUsernameInBackground("myname", password:"mypass") {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
            } else {
                // The login failed. Check error to see why.
            }
        }
    }
    
    func signOut(){
        
        PFUser.logOut()
    }
    
    func signUp(userName:String,pass:String,email:String){
        
        let user = PFUser()
        user.username = "myUsername"
        user.password = "myPassword"
        user.email = "email@example.com"
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
            } else {
                // Hooray! Let them use the app now.
                print("signup success")
            }
        }
    }
}

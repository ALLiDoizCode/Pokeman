//
//  Presenters.swift
//  Pokeman
//
//  Created by Jonathan Green on 2/20/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation

class Presenter {
    
    let theLeaderBoard = LeaderBoard()
    let theAWards = AwardsClient()
    
    func setAward(type:String,status:Bool,completion:(success:Bool) -> Void){
        
        theAWards.setAwards(type, Status: status) { (success) -> Void in
            
            completion(success: success)
        }
    }
    
    func signin(userName:String,pass:String,completion:(success:Bool) -> Void){
        
        theLeaderBoard.signin(userName, pass: pass) { (success) -> Void in
            
            completion(success: success)
        }
    }
    
    func signUp(userName:String,pass:String,email:String,completion:(success:Bool) -> Void){
        
        theLeaderBoard.signin(userName, pass: pass) { (success) -> Void in
            
            completion(success: success)
        }
    }
    
    func logout(){
        
        theLeaderBoard.signOut()
    }
    
    func addScore(score:Int){
       
        theLeaderBoard.addScore(score)
    }
    
    func getScores(user:Bool,completion:(score:[Score]) -> Void){
        
        theLeaderBoard.getScores(user) { (scores) -> Void in
            
            completion(score: scores)
            print("got scores")
        }
    }
}
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
    
    func signin(userName:String,pass:String){
        
        theLeaderBoard.signin(userName, pass: pass)
    }
    
    func signUp(userName:String,pass:String,email:String){
        
        theLeaderBoard.signUp(userName, pass: pass, email: email)
    }
    
    func logout(){
        
        theLeaderBoard.signOut()
    }
    
    func addScore(score:Int){
       
        theLeaderBoard.addScore(score)
    }
    
    /*func getScores(completion:(score:[Score]) -> Void){
        
        theLeaderBoard.getScores { (scores) -> Void in
            
            completion(score: scores)
            print("got scores")
        }
    }*/
}
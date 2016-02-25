//
//  Awards.swift
//  Pokeman
//
//  Created by Jonathan Green on 2/25/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import Parse

class AwardsClient {
    
    
    let currentUser = PFUser.currentUser()
    
    func getAwards(){
        
    }
    
    func setAwards(type:String,Status:Bool,completion:(success:Bool) -> Void){
        
        let userAwards = currentUser?.relationForKey("Awards")
        
        let gameAwards = userAwards?.query()
        
        gameAwards!.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
            
            if let object = object {
                
                guard let currentStatus:Bool = object.objectForKey(type) as? Bool else {
                    
                    object[type] = Status
                    
                    object.saveInBackgroundWithBlock({ (success, error) -> Void in
                        
                        if success == true{
                            
                            print("award save")
                            
                            completion(success: success)
                            
                        }else {
                            
                            print("award not save")
                            //completion(success: success)
                        }
                        
                    })
                    
                    return
                }
                
                print("the status is \(currentStatus)")
                
            }else {
                
                let userAward = PFObject(className: "Awards")
                
                userAward[type] = Status
                
                userAward.saveInBackgroundWithBlock({ (awardSuccess, error) -> Void in
                    
                    
                    if awardSuccess == true {
                        
                        
                        print("award save ")
                        
                        userAwards?.addObject(userAward)
                        
                        self.currentUser?.saveInBackgroundWithBlock({ (userSuccess, error) -> Void in
                            
                            
                            if userSuccess == true {
                                
                                completion(success: awardSuccess)
                            }
                            
                            
                        })
                        
                        
                        
                    }else {
                        
                        print("award not save")
                        completion(success: awardSuccess)
                    }
                })
            }
            
           
        }
        
    }
}
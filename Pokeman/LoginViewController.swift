//
//  LoginViewController.swift
//  Pokeman
//
//  Created by Jonathan Green on 2/20/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let presenter = Presenter()

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    
    override func viewWillAppear(animated: Bool) {
        
        userName.text = ""
        passWord.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signIn(sender: AnyObject) {
        
        if userName.text != "" && passWord.text != "" {
            
            presenter.signin(userName.text!, pass: passWord.text!, completion: { (success) -> Void in
                
                print(success)
                
                if success == true {
                    
                    print("loged in")
                    
                    self.performSegueWithIdentifier("success", sender: self)
                    
                }else {
                    
                    print("issues with login")
                }
            })
            
        }else{
            
            print("some fields missing")
        }
        
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

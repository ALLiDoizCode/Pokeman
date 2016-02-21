//
//  SignupViewController.swift
//  Pokeman
//
//  Created by Jonathan Green on 2/20/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var passWord: UITextField!
    
    
    let presenter = Presenter()
    
    override func viewWillAppear(animated: Bool) {
        
        userName.text = ""
        email.text = ""
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
    
    @IBAction func signUp(sender: AnyObject) {
        
        if userName.text != "" && passWord.text != "" && email.text != "" {
            
            presenter.signUp(userName.text!, pass: passWord.text!, email: email.text!) { (success) -> Void in
                
                if success == true {
                    
                    self.performSegueWithIdentifier("Success", sender: self)
                    
                    print("SignUp success")
                    
                }else{
                    
                    print("SignUp failed")
                }
            }
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

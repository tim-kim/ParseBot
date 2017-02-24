//
//  ViewController.swift
//  ParseBot
//
//  Created by Tim Kim on 2/23/17.
//  Copyright © 2017 Tim Kim. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onLogin(_ sender: AnyObject) {
        
        PFUser.logInWithUsername(inBackground: loginField.text!, password: passwordField.text!) { (user: PFUser?, error: Error?) in
            if user != nil {
                self.performSegue(withIdentifier: "goToChat", sender: self)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
        

    @IBAction func onSignUp(_ sender: AnyObject) {
        let user = PFUser()
        user.username = loginField.text
        user.password = passwordField.text
        user.email = loginField.text
        
        user.signUpInBackground {
            (succeeded: Bool, error: Error?) -> Void in
            if let error =  error{
                print(error.localizedDescription)
            } else {
                print("a user was created")
                self.performSegue(withIdentifier: "chat", sender: self)
            }
        }
        
    }
    
}


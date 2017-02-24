//
//  ChatViewController.swift
//  ParseBot
//
//  Created by Tim Kim on 2/23/17.
//  Copyright © 2017 Tim Kim. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

    @IBOutlet weak var messageField: UITextField!
    @IBAction func onSend(_ sender: AnyObject) {
        let message = PFObject(className: "Message")
        message.setObject(PFUser.current()!, forKey: "User")
        message["text"] = messageField.text
        
        message.saveInBackground { (success: Bool, error: Error?) in
            if (success) {
                print("Saved")
                self.messageField.text = ""
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

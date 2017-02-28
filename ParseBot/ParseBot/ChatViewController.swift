//
//  ChatViewController.swift
//  ParseBot
//
//  Created by Tim Kim on 2/23/17.
//  Copyright © 2017 Tim Kim. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var messages: [PFObject] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageField: UITextField!
    
    @IBAction func onSend(_ sender: AnyObject) {
        let message = PFObject(className: "MessageSF")
        message["user"] = PFUser.current()
        //message.setObject(PFUser.current()!, forKey: "User")
        message["text"] = messageField.text
        
        message.saveInBackground { (success: Bool, error: Error?) in
            if (success) {
                print("sent message")
                self.messageField.text = ""
            } else {
                print("error: \(error)")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        
        queryParse()
        onTimer()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! ChatTableViewCell
        
        let message = self.messages[indexPath.row] as PFObject
        
        print(message)
        cell.message.text = message.object(forKey: "text") as? String
        let user = message.object(forKey: "user") as? PFUser
        if (user?.username) != nil {
            cell.messageSender.text = user?.username
        }
        else {
            cell.messageSender.text = user?.email
        }
        
        cell.message.sizeToFit()
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onTimer() {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ChatViewController.queryParse), userInfo: nil, repeats: true)
    }
    
    func queryParse() {
        let query = PFQuery(className: "MessageSF")
        query.order(byDescending: "createdAt")
        query.includeKey("user")
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if error == nil {
                print("successfully retrieved \(self.messages.count) messages!")
                if let objects = objects {
                    self.messages = objects
                    self.tableView.reloadData()
                }
            } else {
                print("error: \(error)")
            }
        }
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

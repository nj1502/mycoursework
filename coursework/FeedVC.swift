//
//  FeedVC.swift
//  coursework
//
//  Created by Nathan Jayawardene on 2/23/17.
//  Copyright © 2017 Nathan Jayawardene. All rights reserved.
//

import UIKit
import Firebase //imports firebase
import SwiftKeychainWrapper //imports the swiftkeycahinwrapper framework.
//setting up the foundation for the table view
class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() { //view loading in memory
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
        //setting up listener to make sure that what ever changes is tracked (in the firebase atabase)
        // this function will access the posts attribute/object with the singleton. (down)
        // reffering to the posts attribute/child/object
        //.value looks for any value changes, this being whether there is a new child node is added, when a child node is removed, when a child node's location changes, when data changes at a location
        //this prints the snapshot (of the child object/attribute/entities and the value (what is contained in it)
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
                print(snapshot.value)
    
        })
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
    }
    
    
    

    
    @IBAction func signOutTapped(_ sender: Any) { // if signin (actually signout) is tapped this will remove the key stored in key chain and perform a seqgue to the sign in screen
        let keychainResult = KeychainWrapper.standard.remove(key: KEY_UID)
            print("NATHAN: ID REMOVED FROM KEY CHAIN\(keychainResult)")
        try! FIRAuth.auth()?.signOut()
     //try and catch method to make sure this message is displayed it the above action is not carried out. 
            performSegue(withIdentifier: "goToSignIn", sender: nil)
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



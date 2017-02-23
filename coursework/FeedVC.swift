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
    
    
    
       var posts = [Post]() //allows an continous array of posts

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
            // looking for snapshot form specific children object and then checking whether it is a firebase data snashot FIRDataSnapshot 
            //getting all data for each child 
            // attaining 3 objects
            
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {  //This is is essentially a listerner
                    print("SNAP: \(snap)")      // type SNAP to find when testing
                    
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key //assinged snapshot (data contained in key) to key constant
                        let post = Post(postKey: key, postData: postDict) //assings snapshot (of data contained in post object) to post constant
                        self.posts.append(post) // appending each post passed into the array
                    }
                }
            }
            self.tableView.reloadData() //reloading the data - making sure it is constantly referenceing and checking the firebase database.
    })
        
    }
    
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return posts.count //returns integer of posts that are made in the array as the integer for tableView (for how many rows there will be)
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //basically gets specific entities/child/objects (captions) from the posts object
          let post = posts[indexPath.row] // get post from post array based on index path and then print captions specifically (ERROR handling to check whether it is working)
        print("NATHAN:\(post.caption)")
        
        return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
    }

    //TESTING CARRIED OUT FOR THISS CHECK BOTTOM LEFT SCREEN FOR NATHAN: ... (they will be captions
    
    
    
    
    

    
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



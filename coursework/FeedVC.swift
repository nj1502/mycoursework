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

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInTapped(_ sender: Any) { // if signin (actually signout) is tapped this will remove the key stored in key chain and perform a seqgue to the sign in screen
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



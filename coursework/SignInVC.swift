//
//  ViewController.swift
//  coursework
//
//  Created by Nathan Jayawardene on 2/23/17.
//  Copyright © 2017 Nathan Jayawardene. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//What happens when the facebook applicaiton is pressed 
    
    @IBAction func facebookBtnTapped(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        // ERROR HANDLING
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil { //request read permission for users email
                print("NATHAN: Unable to authenticate with Facebook - \(error)")
            } else if result?.isCancelled == true {
                print("NATHAN: User cancelled Facebook authentication")
            } else { //This is when user is given option to cancell authentication with facebook
                print("NATHAN: Successfully authenticated with Facebook") //this is when facebook when the account is successfull authenticaed.
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
                //This calls the method below to make sure that firebase authenticates the above connection with facebook.
            }
        }
        
    }
    func firebaseAuth(_ credential: FIRAuthCredential) { //Authentication with firebase
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil { //ERROR HANDLING
                print("NATHAN: Unable to authenticate with Firebase - \(error)")
            } else {
                print("NATHAN: Successfully authenticated with Firebase")
                }
        })
    }
}



        
        
        
        





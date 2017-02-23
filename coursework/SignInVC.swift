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
import SwiftKeychainWrapper
//this uploads the swift keychain wrapper framework (it will allow us to auto-sign in if we have already done so beforehand) using keychain if user id found it will segeue to new class screen


class SignInVC: UIViewController {

    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var pwdField: FancyField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        //if the key does exist with in the keychain then a segue to the next view controller is performed, essentially switching screens.
        
    }
    // THIS PART IS FOR AUTO SIGNIN MENTINO THAT !
    
//EVEN IF USERS DELETE KEY CHAIN THEY WILL STILL BE SIGNING UP
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.defaultKeychainWrapper.string(forKey: KEY_UID){
            print("NATHAN: ID found in keychain") //if there is a keychain with string KEY_UID then automatically sign in.
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
}





//What happens when the facebook applicaiton is pressed 
    
    @IBAction func facebookBtnTapped(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        // ERROR HANDLING
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                
                //request read permission for users email
                
                print("NATHAN: Unable to authenticate with Facebook - \(error)")
            } else if result?.isCancelled == true {
                print("NATHAN: User cancelled Facebook authentication")
                
            } else {
                //This is when user is given option to cancell authentication with facebook
                
                print("NATHAN: Successfully authenticated with Facebook")
                //this is when facebook when the account is successfull authenticaed.
                
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
                
                //This calls the method below to make sure that firebase authenticates the above connection with facebook.
            }
        }
        
    }
    func firebaseAuth(_ credential: FIRAuthCredential) { //Authentication with firebase
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                
                //ERROR HANDLING making sure that if user id is not met then it is doubel chek
                
                print("NATHAN: Unable to authenticate with Firebase - \(error)")
            } else {
                print("NATHAN: Successfully authenticated with Firebase")
                if let user = user {
                    let userData = ["provider": user.providerID]
                    self.completeSignIn(id: user.uid, userData: userData)
                    
                    //this is the completetion handler of the one above
                
                }
            }
        })
    }
    
    
    //once the sign in button is passed first we must check whether there is actual text with in the field
    // ERROR HANDLING!!!
    @IBAction func signInTapped(_ sender: Any) {
        if let email = emailField.text, let pwd = pwdField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil { //if there is a user check with information stored and firebase and authenticate and then signin
                    print("NATHAN: Email user authenticated with Firebase")
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        self.completeSignIn(id: user.uid, userData: userData)
                    }
                }else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        //if there isnt a user check with firebase online create information for user on firebase and then make sure they are authenticated.
                        
                        if error != nil {
                            print("NATHAN: Unable to authenticate with Firebase using email")
                        } else {
                            print("NATHAN: Successfully authenticated with Firebase")
                            // if successfully authenticated with firebase
                            if let user = user {
                                let userData = ["provider": user.providerID]
                                self.completeSignIn(id: user.uid, userData: userData)
                                //calls the function completeSignIn to also create a new entity in the user attribute for firebase by using user id (or is user table? double check and see)
                                //
                                //ERROR handling if this is met then the funciton below for calling keychaniwrapper is called. This check whether something exits in the user.
                            }
                        }
                    })
                }
            })
        }
    }
    
        // create a function to call KeychainWrapper in the functions above, when called it will write the users details into the key chain.
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        
        DataService.ds.createFirbaseDBUser(uid: id, userData: userData)
        //let keychainResult = KeychainWrapper.setString(id, forKey: KEY_UID)
        //This creates a new entity in the user attribtue in the firebase database
        
        let keychainResult = KeychainWrapper.defaultKeychainWrapper.set(id, forKey: KEY_UID)
        //message the is provided when user information is saved to keychain.
        // as well as providing
        
        print("JESS: Data saved to keychain \(keychainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
        //this performs the segue if the keychain is stored.
    }
    
}








        
        

        





//
//  DataService.swift
//  coursework
//
//  Created by Nathan Jayawardene on 2/23/17.
//  Copyright © 2017 Nathan Jayawardene. All rights reserved.
//

import Foundation
import Firebase //importing firebase SDK

let DB_BASE = FIRDatabase.database().reference() //this generates a reference to the base url of our database.

//create reference to the base url of firebase database storage
let STORAGE_BASE = FIRStorage.storage().reference()



class DataService{ //creating class for communication with firebase database
    
    static let ds = DataService()
    //singelton instance of a classs that is globally accesable that is only one instance.
    // everything below is globally accessible as such
    
    // DB references--------------------------------------------------------------------------------
    private var _REF_BASE = DB_BASE
    //this refences the root/base of the firebase database
    
    
    private var _REF_POSTS = DB_BASE.child("posts")
    //this referene to the child charactersitic, posts of the root/base url of the database
    
    
    private var _REF_USERS = DB_BASE.child("users")
    //this referene to the child charactersitic, users of the root/base url of the database

    //Storage references----------------------------------------------------------------------------
    private var _REF_POST_IMAGES = STORAGE_BASE.child("post-pics")
    //create reference to name of the files in this case post-pics
    
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_POSTS: FIRDatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    var REF_POST_IMAGES: FIRStorageReference {
        return _REF_POST_IMAGES
    }//refers to the stored images on the databse and returns them
    

    
    
    
// This function creates a userfield on the database, by creating a dictionary that the code can reference from
// because the data cannot be retireved driectly from firebase database it is retrieved when the authentication process for a user sigin is carried out.  
    //it will take in information for userid (uid) and userData
    func createFirbaseDBUser(uid: String, userData: Dictionary<String, String>) {
        REF_USERS.child(uid).updateChildValues(userData)
        
        //reference to where the program will write it
        //creating a user on firebase database 
        //update child values - passes user data in
            //if data exist data will be added to the current exisiting attribute
            // if data doesnt exist new data will be created 
            //does not overwrite    }
    
    
}
}

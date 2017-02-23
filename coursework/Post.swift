//
//  Post.swift
//  coursework
//
//  Created by Nathan Jayawardene on 2/23/17.
//  Copyright © 2017 Nathan Jayawardene. All rights reserved.
//

import Foundation

class Post{
    //properties in the firebase database object that will be acquired
    private var _caption: String!
    private var _imageUrl: String!
    private var _likes: Int!
    private var _postKey: String!
    
    // acquiring these above computer properities
    
    var caption: String {
        return _caption   // returns caption entities as a string
    }
    
    var imageUrl: String {
        return _imageUrl    //returns image url as a string
    }
    
    var likes: Int {
        return _likes    // returns number of likes entities as an integer
    }
    
    var postKey: String {
        return _postKey  //postkey the id of the particular object i.e. 215thug8i
        
    }

    init(caption: String, imageUrl: String, likes: Int) {
        self._caption = caption
        self._imageUrl = caption
        self._likes = likes
    }
    // the bottom init will pass string to convert data firbase into a useable format.
    init(postKey: String, postData: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        
        if let caption = postData["caption"] as? String {
            self._caption = caption  //will search for caption as an attribute/object/child (as a string) when accessing firebase database
        }
        
        if let imageUrl = postData["imageUrl"] as? String {
            self._imageUrl = imageUrl   //will search for imageUrl as an attribute/object/child (as a string) when accessing firebase database
        }
        
        if let likes = postData["likes"] as? Int {
            self._likes = likes //will search for likes as an attribute/object/child (as integer) when accessing firebase database 
        }
        
        
    }
    
    
    
    
}

//
//  PostCell.swift
//  coursework
//
//  Created by Nathan Jayawardene on 2/23/17.
//  Copyright © 2017 Nathan Jayawardene. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {
    
    
    //creating IBoutlets to modify data per cell in the table
    @IBOutlet weak var profileImg: UIImageView!  // this is to point to the pofile image
    @IBOutlet weak var usernameLbl: UILabel!     // this references the username
    @IBOutlet weak var postImg: UIImageView!     // this referennces the post image
    @IBOutlet weak var caption: UITextView!      // this references the caption you put on the image
    @IBOutlet weak var likesLbl: UILabel!        // this references the like label

     var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    
    
    //if there is an image in cache (optional) then pass through, optional used incase image isnt in cache
    func configureCell(post: Post, img: UIImage? = nil) {
        
        
        self.post = post
        self.caption.text = post.caption
        self.likesLbl.text = "\(post.likes)" //int (the number of likes) passed as a string 
        
    
        if img != nil {
            self.postImg.image = img
            //if image does exist set postimage to the image
        } else {
            //bring down data passed in as the url
            let ref = FIRStorage.storage().reference(forURL: post.imageUrl)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
            //pass the string (image url)
            // this will calculate the max filesize the image can be (in this case 2 Megabytes)
                
            if error != nil {
            // This is incase image cannot be download from storage and error will be displayed ERROR HANDLING
                print("NATHAN: Unable to download image from Firebase storage")
                
            } else {
                
                print("NATHAN: Image downloaded from Firebase storage")
                                    
                                    
                // error message displayed incase image cannot be downloaded
                //next condition will save data to the cacha create in feedvc class

                if let imgData = data {
                    //if image data has been successfully cahced out
                    if let img = UIImage(data: imgData) {
                        self.postImg.image = img
                    // this will save to the image cache in the feedvc class 
                        //becuase is is a global variable we referecne the calss
                        FeedVC.imageCache.setObject(img, forKey: post.imageUrl as NSString)
                        
                    }
                }
                }
            })
        }
    }
}

                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        

//
//  PostCell.swift
//  coursework
//
//  Created by Nathan Jayawardene on 2/23/17.
//  Copyright © 2017 Nathan Jayawardene. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    
    //creating IBoutlets to modify data per cell in the table
    @IBOutlet weak var profileImg: UIImageView!  // this is to point to the pofile image
    @IBOutlet weak var usernameLbl: UILabel!     // this references the username
    @IBOutlet weak var postImg: UIImageView!     // this referennces the post image
    @IBOutlet weak var caption: UITextView!      // this references the caption you put on the image
    @IBOutlet weak var likesLbl: UILabel!        // this references the like label

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    



}

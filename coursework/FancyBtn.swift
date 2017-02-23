//
//  FancyBtn.swift
//  coursework
//
//  Created by Nathan Jayawardene on 2/23/17.
//  Copyright © 2017 Nathan Jayawardene. All rights reserved.
//

import UIKit
// this class add shadowing image effect to the sign in button
class FancyBtn: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.cornerRadius = 2.0 // this make sure that the edges of the buttons are curved. 
    }
    


}

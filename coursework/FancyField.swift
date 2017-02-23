//
//  FancyField.swift
//  coursework
//
//  Created by Nathan Jayawardene on 2/23/17.
//  Copyright © 2017 Nathan Jayawardene. All rights reserved.
//

import UIKit
// this class adds shadwoing to the text fields and their entries as well as workout the border distacneces
class FancyField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        // this make sure shadgwing is added
        layer.borderColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.2).cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 2.0 //this make the border curved

}
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5) //this funciton makes sure they are in the right position via axis on the screen 
}
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
}
}

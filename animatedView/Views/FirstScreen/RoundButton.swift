//
//  RoundButton.swift
//  animatedView
//
//  Created by Agata on 21.10.2023.
//

import Foundation
import UIKit

@IBDesignable
class RoundButton : UIButton {
    @IBInspectable var roundButton : Bool = false {
        didSet {
            if roundButton {
                layer.cornerRadius = frame.height/2
            }
        }
    }
    
    override func prepareForInterfaceBuilder() {
        if roundButton {
            layer.cornerRadius = frame.height/2
        }
    }
}

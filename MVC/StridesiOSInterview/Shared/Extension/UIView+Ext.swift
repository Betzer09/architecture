//
//  UIView+Ext.swift
//  StridesiOSInterview
//
//  Created by Austin Betzer on 4/27/21.
//

import Foundation
import UIKit

@IBDesignable
extension UIView {
    
    @IBInspectable var vCornerRadius: CGFloat {
        set (radius) {
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = radius > 0
        }
        
        get {
            return self.layer.cornerRadius
        }
    }

    @IBInspectable var vTopCornerRadius: CGFloat {
        set (radius) {
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            self.layer.masksToBounds = radius > 0
        }
        
        get {
            return self.layer.cornerRadius
        }
    }
    
    @IBInspectable var bottomCornerRadius: CGFloat {
        set (radius) {
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = [.layerMaxXMinYCorner ,.layerMaxXMaxYCorner]
            self.layer.masksToBounds = radius > 0
        }
        
        get {
            return self.layer.cornerRadius
        }
    }
    
    @IBInspectable var vBorderWidth: CGFloat {
        set (borderWidth) {
            self.layer.borderWidth = borderWidth
        }
        
        get {
            return self.layer.borderWidth
        }
    }
    
    @IBInspectable var vBorderColor:UIColor? {
        set (color) {
            self.layer.borderColor = color?.cgColor
        }
        
        get {
            if let color = self.layer.borderColor {
                return UIColor(cgColor: color)
            } else {
                return nil
            }
        }
    }
}


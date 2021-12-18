//
//  UIUtils.swift
//  StridesiOSInterview
//
//  Created by Austin Betzer on 4/27/21.
//

import Foundation
import UIKit

class UIUtils {
    /**
     Creates a simple action sheet and presents it.
     
     - parameter title: The title of the alert
     - parameter message: The message you would like to dispaly
     - parameter cancelTitle: The title of the cancel button
     */
    class func showSimpleActionAlert(vc: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(okayAction)
        vc.present(alert, animated: true, completion: nil)
    }
}

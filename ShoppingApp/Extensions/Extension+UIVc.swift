//
//  Extension+UIVc.swift
//  ShoppingApp
//
//  Created by ugur-pc on 21.05.2022.
//

import UIKit
import FirebaseAuth

extension UIViewController {
    
     func alertCustomFunc(title: String, msg: String,  prefStyle: UIAlertController.Style,  fontSize: CGFloat,  textColor: UIColor, bgColor: UIColor) {
        let alert = UIAlertController(title: title,
                                      message: msg,
                                      preferredStyle: prefStyle)
        let okAct = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        let messageAttributes = [NSAttributedString.Key.font: UIFont(name: "GillSans-Italic", size: fontSize)!, NSAttributedString.Key.foregroundColor: textColor]
        
        let messageString = NSAttributedString(string: msg, attributes: messageAttributes)
        alert.setValue(messageString, forKey: "attributedMessage")
        
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = bgColor
        alert.addAction(okAct)
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - Create Alert
    func createAlert(title: String,
                     msg: String,
                     prefStyle: UIAlertController.Style,
                     bgColor: UIColor,
                     textColor: UIColor,
                     fontSize: CGFloat) {
        
        alertCustomFunc(title: title, msg: msg, prefStyle: prefStyle, fontSize: fontSize, textColor: textColor, bgColor: bgColor)
        
    }
    
    
    //MARK: - Handle Fire Auth Err
    func handleFireAuthError(error: Error,
                             fontSize: CGFloat,
                             textColor: UIColor,
                             bgColor: UIColor) {
        
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            alertCustomFunc(title: "Error", msg:  errorCode.errorMessage, prefStyle: .alert, fontSize: fontSize, textColor: textColor, bgColor: bgColor)
            
        }
    }
}


//MARK: -
extension AuthErrorCode {
    var errorMessage: String {
        switch self {
        case .emailAlreadyInUse:
            return "The email is already in use!"
            
        case .userNotFound:
            return "Account not found for the specified user. Please check and try again"
        case .userDisabled:
            return "Your account has been disabled. Please contact support."
        case .invalidEmail:
            return "Please enter a valid email!"
        case .networkError:
            return "Network error. Please try again!"
        case .weakPassword:
            return "The password must be 6 characters long or more!"
        case .wrongPassword:
            return "Your password or email is incorrect!"
        default:
            return "Sorry, something went wrong!"
        }
    }
}

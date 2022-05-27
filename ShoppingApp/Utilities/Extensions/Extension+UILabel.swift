//
//  Extension+UILabel.swift
//  ShoppingApp
//
//  Created by ugur-pc on 27.05.2022.
//

import UIKit

extension UILabel {

     func colorString(text: String?,
                      coloredText: String?,
                      color: UIColor) {

     let attributedString = NSMutableAttributedString(string: text!)
     let range = (text! as NSString).range(of: coloredText!)
         attributedString.setAttributes([NSAttributedString.Key.foregroundColor: color,
                                         NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 18.0)!
                                        ],
                              range: range)
     self.attributedText = attributedString
 }
}

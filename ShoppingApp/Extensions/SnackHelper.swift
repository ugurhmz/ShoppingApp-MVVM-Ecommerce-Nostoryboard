//
//  SnackHelper.swift
//  ShoppingApp
//
//  Created by ugur-pc on 21.05.2022.
//

import UIKit
import SwiftEntryKit

class SnackHelper {
    
    class func showSnack(message: String, bgColor: UIColor, textColor: UIColor) {
        let contentView = UIView()
        contentView.backgroundColor = bgColor
        contentView.anchor(top: nil,
                           leading: nil,
                           bottom: nil,
                           trailing: nil,
                           size: .init(width: 0, height: 40))
        contentView.layer.cornerRadius = 30
        
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 23)
        label.textColor = textColor
        label.numberOfLines = 0
        label.text = message
        contentView.addSubview(label)
        label.fillSuperview()

        var attributes = EKAttributes.centerFloat
        attributes.screenBackground = .color(color: .init(light: UIColor(white: 100.0/255.0, alpha: 0.3), dark: UIColor(white: 150.0/255.0, alpha: 0.3)))
        attributes.shadow = .active(
            with: .init(
                color: .black,
                opacity: 0.3,
                radius: 8
            )
        )
        
        attributes.entryBackground = .color(color: .standardBackground)
        attributes.roundCorners = .all(radius: 25)
        
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .enabled(
            swipeable: true,
            pullbackAnimation: .jolt
        )
        
        attributes.entranceAnimation = .init(
            translate: .init(
                duration: 0.7,
                spring: .init(damping: 1, initialVelocity: 0)
            ),
            scale: .init(
                from: 1.05,
                to: 1,
                duration: 0.4,
                spring: .init(damping: 1, initialVelocity: 0)
            )
        )
        
        attributes.exitAnimation = .init(
            translate: .init(duration: 0.2)
        )
        attributes.popBehavior = .animated(
            animation: .init(
                translate: .init(duration: 0.2)
            )
        )
        
        attributes.positionConstraints.verticalOffset = 10
        attributes.statusBar = .dark
     
        
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }

}

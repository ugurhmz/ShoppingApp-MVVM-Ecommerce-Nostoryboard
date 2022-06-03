//
//  CheckOutReusableView.swift
//  ShoppingApp
//
//  Created by ugur-pc on 3.06.2022.
//

import UIKit

class CheckOutReusableView: UICollectionReusableView {
    static var Identifier = "CheckOutReusableView"
    
    private let checkoutView = CartView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        checkoutView.backgroundColor = .orange
        addSubview(checkoutView)
        checkoutView.anchor(top: topAnchor ,
                      leading: leadingAnchor,
                      bottom: bottomAnchor,
                      trailing: trailingAnchor,
                      padding: .init(top: 10, left: 20, bottom: 10, right: 20)
        )
            
        checkoutView.layer.cornerRadius = 40
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
}

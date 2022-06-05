//
//  CartItemsView.swift
//  ShoppingApp
//
//  Created by ugur-pc on 4.06.2022.
//

import UIKit

class CartItemsView: UIView {
    
    private let cartImgView: UIImageView = {
         let iv = UIImageView()
         iv.image = UIImage(named: "cartimg")
         iv.contentMode = .scaleToFill
         iv.clipsToBounds = true
         iv.layer.cornerRadius = 15
         iv.layer.borderWidth = 0.3
         return iv
    }()
    
    var cartLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 27, weight: .bold)
        label.text = "4544"
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 2.5
        label.layer.shadowRadius = 2.0
      
        label.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        label.textColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
    
    private func setupViews(){
        addSubview(cartImgView)
        addSubview(cartLbl)
    }

}

extension CartItemsView {
    func fillData(_ count: Int){
        
        self.cartLbl.text = "\(count)"
    }
}

//MARK: -
extension CartItemsView {
    private func  setConstraints() {
        cartImgView.anchor(top: topAnchor,
                          leading: leadingAnchor,
                          bottom: bottomAnchor,
                          trailing: trailingAnchor,
                          padding: .init(top: 0, left: 0, bottom: 0, right: 0),
                          size: .init(width: 0, height: 100)
        )
        
        cartLbl.anchor(top: nil,
                      leading: nil,
                      bottom: bottomAnchor,
                      trailing: trailingAnchor,
                      padding: .init(top: 15, left: 4, bottom: 0, right: 0),
                      size: .init(width: 80, height: 40))
        
    }
}

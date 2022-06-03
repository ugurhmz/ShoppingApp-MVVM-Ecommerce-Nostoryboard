//
//  CartView.swift
//  ShoppingApp
//
//  Created by ugur-pc on 3.06.2022.
//

import UIKit

class CartView: UIView {

    
    private var checkOutBtn: UIButton = {
        let buton = UIButton(type: .system)
         buton.setTitle("Check Out", for: .normal)
         buton.backgroundColor = UIColor(red: 197/255, green: 33/255, blue: 52/255, alpha: 1)
         buton.setTitleColor(.white, for: .normal)
         buton.layer.cornerRadius = 45
         buton.layer.masksToBounds = true
         buton.titleLabel?.font = .systemFont(ofSize: 21, weight: .bold)
         buton.addTarget(self, action: #selector(clickCheckOutBtn), for: .touchUpInside)
         return buton
     }()
    
    @objc func clickCheckOutBtn(){
        print("click")
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    private func setupViews(){
        
       addSubview(checkOutBtn)
        let strCast = "2500"
        let addCartStr = "Check Out | "
        
        let str = NSMutableAttributedString(string: "\(addCartStr)\(strCast) TL")
        str.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 29), range: NSMakeRange(0, addCartStr.count))
        str.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 22), range: NSMakeRange(addCartStr.count, strCast.count + 3))
        self.checkOutBtn.setAttributedTitle(str, for: .normal)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }

}

//MARK: -
extension CartView {
    private func setConstraints(){
        checkOutBtn.anchor(top: topAnchor,
                           leading: leadingAnchor,
                           bottom: bottomAnchor,
                           trailing: trailingAnchor)
    }
}

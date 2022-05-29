//
//  ByCategoryHeaderView.swift
//  ShoppingAdmin
//
//  Created by ugur-pc on 29.05.2022.
//

import UIKit

class ByCategoryHeaderView: UIView {
    

    private let headerLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "Merhaba"
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(headerLbl)
        setConstraints()
    }
     
    
    override var intrinsicContentSize: CGSize {
            return CGSize(width: 100, height: 100)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: -
extension ByCategoryHeaderView {
    private func setConstraints(){
        headerLbl.anchor(top: topAnchor,
                         leading: leadingAnchor,
                         bottom: nil,
                         trailing: trailingAnchor,
                         padding: .init(top: 5, left: 5, bottom: 0, right: 5)
        )
    }
}

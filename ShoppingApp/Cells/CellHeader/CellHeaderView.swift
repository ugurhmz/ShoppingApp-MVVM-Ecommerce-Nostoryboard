//
//  HeaderReusableView.swift
//  FurnitureShop
//
//  Created by ugur-pc on 19.05.2022.
//

import UIKit

class CellHeaderView: UICollectionReusableView {
    static var identifier = "HeaderReusableView"
    
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        setConstraints()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
    }
    
    func setConstraints(){
        titleLabel.anchor(top: topAnchor,
                          leading: leadingAnchor,
                          bottom: bottomAnchor,
                          trailing: trailingAnchor,
                          padding: .init(top: 20, left: 10, bottom: 8, right: 0))
    }
    
}

//
//  ZeroCustomCell.swift
//  FurnitureShop
//
//  Created by ugur-pc on 19.05.2022.
//

import UIKit

class ZeroCustomCell: UICollectionViewCell {
    
    static var identifier  = "Mycell"
    
    
    public var imgView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "v6")
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 50
        return iv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imgView)
        imgView.fillSuperview()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
    
    
}

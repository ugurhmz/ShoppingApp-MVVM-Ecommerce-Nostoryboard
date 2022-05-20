//
//  GeneralCustomCell.swift
//  FurnitureShop
//
//  Created by ugur-pc on 19.05.2022.
//

import UIKit

class OneCustomCell: UICollectionViewCell {
    static var identifier  = "OtherCell"
    
    
    public var imgView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "v6")
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 40
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

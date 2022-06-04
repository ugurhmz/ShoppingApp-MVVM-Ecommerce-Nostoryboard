//
//  AdvertiseCell.swift
//  ShoppingApp
//
//  Created by ugur-pc on 25.05.2022.
//

import UIKit

class AdvertiseCell: UICollectionViewCell {
    static var identifier = "AdvertiseCell"
    
     var advertiseImg: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "v4")
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 20
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(advertiseImg)
        setConstraints()
        setStyle()
    }
    
    private func setStyle(){
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
    
}
extension AdvertiseCell {
    func fillImage(imgStr: String)  {
        self.advertiseImg.image = UIImage(named: imgStr)
    }
}

//MARK: -
extension AdvertiseCell  {
    private func setConstraints(){
        advertiseImg.anchor(top: contentView.topAnchor,
                       leading: contentView.leadingAnchor,
                            bottom: contentView.bottomAnchor,
                       trailing: contentView.trailingAnchor )
       
    }
}


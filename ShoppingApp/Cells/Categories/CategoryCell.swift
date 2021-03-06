//
//  ZeroCustomCell.swift
//  FurnitureShop
//
//  Created by ugur-pc on 19.05.2022.
//

import UIKit
import Kingfisher

class CategoryCell: UICollectionViewCell {
    
    static var identifier  = "Mycell"
    
    public var categoryImg: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 20
        return iv
    }()
    
    private let categoryNameLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(categoryImg)
        contentView.addSubview(categoryNameLbl)
        setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
}


//MARK: -  Fill data
extension CategoryCell {
    func fillCategoryData(category: CategoryModel){
        categoryNameLbl.text = category.name
        if let url = URL(string: category.imgUrl) {
            let placeholder = UIImage(named: "placeholder")
            let options: KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.8))]
            categoryImg.kf.indicatorType = .activity
            categoryImg.kf.setImage(with: url, placeholder: placeholder, options: options)
        }
    }
}

//MARK: -
extension CategoryCell {
    private func setConstraints(){
        categoryImg.anchor(top: contentView.topAnchor,
                       leading: contentView.leadingAnchor,
                       bottom: nil,
                       trailing: contentView.trailingAnchor,
                           padding: .init(top: 0, left: 0, bottom: 0, right: 10),
                       size: .init(width: 0, height: self.frame.height - 32 ))
               
        categoryNameLbl.anchor(top: categoryImg.bottomAnchor,
                                 leading: leadingAnchor,
                                 bottom: bottomAnchor,
                                 trailing: trailingAnchor,
                                 padding: .init(top: 5, left: 0, bottom: 10, right: 0))
    }
}

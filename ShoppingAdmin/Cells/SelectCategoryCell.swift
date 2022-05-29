//
//  SelectCategoryCell.swift
//  ShoppingAdmin
//
//  Created by ugur-pc on 29.05.2022.
//

import UIKit
import Kingfisher


class SelectCategoryCell: UICollectionViewCell {
    static var identifier = "SelectCategoryCell"
   
    
    private var categoryNameLbl: UILabel = {
        let label = UILabel()
        label.text = "abc"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .white
        label.numberOfLines = 3
      
        return label
    }()
    
    private var categoryimgView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
       
        return iv
    }()
    
    
    override  init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(categoryNameLbl)
        contentView.addSubview(categoryimgView)
        setConstraints()
        contentView.layer.cornerRadius = 20
        categoryimgView.layer.zPosition = -1
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
}


//MARK: - Fill Bool
extension SelectCategoryCell {
    
    func data(data: CategoryModel) {
        if let prdImgUrl = URL(string: data.imgUrl) {
            let placeholder = UIImage(named: "placeholder")
            let options: KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.8))]
            self.categoryimgView.kf.indicatorType = .activity
            self.categoryimgView.kf.setImage(with: prdImgUrl, placeholder: placeholder, options: options)
        }
        self.categoryNameLbl.text = data.name
       
    }
    
    func configure(select: Bool) {
        if select {
            contentView.layer.borderWidth = 3
            contentView.layer.borderColor =  UIColor.orange.cgColor
            contentView.backgroundColor = .orange
            contentView.layer.cornerRadius = 12
        } else {
            contentView.layer.borderWidth = 0
            contentView.layer.borderColor = .none
            contentView.backgroundColor = .lightGray.withAlphaComponent(0.8)
            contentView.layer.cornerRadius = 12
        }
    }
}

//MARK: -
extension SelectCategoryCell {
    private func setConstraints(){
        categoryNameLbl.centerYInSuperview()
        categoryNameLbl.centerXInSuperview()
        categoryimgView.anchor(top: contentView.topAnchor,
                               leading: contentView.leadingAnchor,
                               bottom: contentView.bottomAnchor,
                               trailing: contentView.trailingAnchor
                            )
    }
}

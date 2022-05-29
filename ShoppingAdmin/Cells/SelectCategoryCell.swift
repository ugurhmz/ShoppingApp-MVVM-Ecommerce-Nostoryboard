//
//  SelectCategoryCell.swift
//  ShoppingAdmin
//
//  Created by ugur-pc on 29.05.2022.
//

import UIKit


class SelectCategoryCell: UICollectionViewCell {
    static var identifier = "SelectCategoryCell"
   
    
    var categoryNameLbl: UILabel = {
        let label = UILabel()
        label.text = "abc"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 3
      
        return label
    }()
    
    
    
    override  init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(categoryNameLbl)
        setConstraints()
        contentView.layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
}


//MARK: - Fill Bool
extension SelectCategoryCell {
    
    func data(data: CategoryModel) {
        self.categoryNameLbl.text = data.name
    }
    
    
    
    func configure(select: Bool) {
        if select {
            contentView.layer.borderWidth = 0.7
            contentView.layer.borderColor =  UIColor.orange.cgColor
            contentView.backgroundColor = .orange
        
        } else {
            contentView.layer.borderWidth = 0
            contentView.layer.borderColor = .none
            contentView.backgroundColor = .lightGray.withAlphaComponent(0.8)
        }
    }
}

//MARK: -
extension SelectCategoryCell {
    private func setConstraints(){
        categoryNameLbl.anchor(top: contentView.topAnchor,
                               leading: contentView.leadingAnchor,
                               bottom: contentView.bottomAnchor,
                               trailing: contentView.trailingAnchor
                            )
        
      
       
    }
}

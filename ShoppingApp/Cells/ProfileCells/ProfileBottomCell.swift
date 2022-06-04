//
//  ProfileBottomCell.swift
//  ShoppingApp
//
//  Created by ugur-pc on 4.06.2022.
//

import UIKit

class ProfileBottomCell: UICollectionViewCell {
    static var identifier = "ProfileBottomCell"
    
    private let allFavItemsView = FavItemsViews()
    private let allCartItemsView = CartItemsView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
}

//MARK: -
extension ProfileBottomCell {
    private func setupViews(){
        addSubview(allFavItemsView)
        addSubview(allCartItemsView)
        
        allFavItemsView.layer.shadowColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1).cgColor
        allFavItemsView.layer.shadowOffset = CGSize(width: 2, height: 2)
        allFavItemsView.layer.shadowOpacity = 2.8
        allFavItemsView.layer.shadowRadius = 8
        
        
        allCartItemsView.layer.shadowColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1).cgColor
        allCartItemsView.layer.shadowOffset = CGSize(width: 2, height: 2)
        allCartItemsView.layer.shadowOpacity = 2.8
        allCartItemsView.layer.shadowRadius = 8
        
        allFavItemsView.layer.cornerRadius = 15
        allCartItemsView.layer.cornerRadius = 15
    }
    
    private func setConstraints(){
        allFavItemsView.anchor(top: contentView.topAnchor,
                               leading: contentView.leadingAnchor,
                               bottom: nil,
                               trailing: nil,
                               padding: .init(top: 20, left: 4, bottom: 0, right: 4),
                               size: .init(width: contentView.frame.width / 2 - 10,
                                           height: 200))
        
        allCartItemsView.anchor(top: contentView.topAnchor,
                                leading: allFavItemsView.trailingAnchor,
                                bottom: nil,
                                trailing: contentView.trailingAnchor,
                                padding: .init(top: 20, left: 7, bottom: 0, right: 4),
                                size: .init(width: contentView.frame.width / 2 - 11,
                                            height: 200))
    }
}

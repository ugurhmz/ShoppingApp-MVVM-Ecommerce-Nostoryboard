//
//  ProductsTwoCell.swift
//  ShoppingApp
//
//  Created by ugur-pc on 24.05.2022.
//

import UIKit

class ProductsTwoCell: UICollectionViewCell {
    static var identifier = "ProductsTwoCell"
    
    public var prdimgView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "v6")
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
       
        return iv
    }()
    
    private let prdPriceLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.text = "6,10 TL"
        label.textColor = .black
        label.textAlignment = .left
        
      
        return label
    }()
    
    
    
    private let prdNameLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.text = "Ekmek Ekmek Ekmek Ekmek Ekmek Ekmek Ekmek Ekmek Ekmek Ekmek Ekmek Ekmek Ekmek Ekmek Ekmek Ekmek "
        label.textColor = #colorLiteral(red: 0.1709887727, green: 0.1870856636, blue: 0.2076978542, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 2
      
        return label
    }()
    
    private var addToCartBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setBackgroundImage(UIImage(systemName: "plus"), for: .normal)
        btn.tintColor = .orange
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 15
        //btn.addTarget(self, action: #selector(clickAddToCartBtn), for: .touchUpInside)
       
       return btn
   }()
    
    private let addToFavouriteBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setBackgroundImage(UIImage(named: "likeunselected"), for: .normal)
       
        btn.tintColor = .black
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 15

      // btn.addTarget(self, action: #selector(clickFavouriteBtn), for: .touchUpInside)
       return btn
   }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
        customStyle()
        bringSubviewToFront(addToCartBtn)
        bringSubviewToFront(addToFavouriteBtn)
       
    }
    
    private func setupViews(){
        addSubview(prdimgView)
        addSubview(prdNameLbl)
        addSubview(prdPriceLbl)
        addSubview(addToCartBtn)
        addSubview(addToFavouriteBtn)
    }
    
    private func customStyle(){
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 0.3
        contentView.layer.cornerRadius = 12
     
      
        contentView.layer.shadowOpacity = 5
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        contentView.layer.masksToBounds = true
        
        addToCartBtn.layer.shadowOpacity = 12
        addToCartBtn.layer.shadowRadius = 12
        addToCartBtn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
     
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
    
}

//MARK: -
extension ProductsTwoCell {
    private func setConstraints(){
        prdimgView.anchor(top: topAnchor,
                          leading: leadingAnchor,
                       bottom: nil,
                       trailing: trailingAnchor,
                          size: .init(width: 0, height: contentView.bounds.height / 1.4 ))
    
        prdPriceLbl.anchor(top: prdimgView.bottomAnchor,
                           leading: leadingAnchor,
                           bottom: nil,
                           trailing: trailingAnchor,
                           padding: .init(top: 3, left: 5, bottom: 0, right: 0))

        prdNameLbl.anchor(top: prdPriceLbl.bottomAnchor,
                          leading: leadingAnchor,
                          bottom: nil,
                          trailing: trailingAnchor,
                          padding: .init(top: 3, left: 5, bottom: 2, right: 0))
        
        addToCartBtn.anchor(top: nil,
                            leading: nil,
                            bottom: prdimgView.bottomAnchor,
                            trailing: prdimgView.trailingAnchor,
                            padding: .init(top: 0, left:0, bottom: 12, right: 10 ),
                            size: .init(width: 42, height: 42))
        
        addToFavouriteBtn.anchor(top: prdimgView.topAnchor,
                                 leading: nil,
                                 bottom: nil,
                                 trailing: prdimgView.trailingAnchor,
                                 padding: .init(top: 10, left:0, bottom: 0, right: 10 ),
                                 size: .init(width: 30, height: 30))
    }
}

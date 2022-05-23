//
//  GeneralCustomCell.swift
//  FurnitureShop
//
//  Created by ugur-pc on 19.05.2022.
//

import UIKit
import Kingfisher

class ProductsOneCell: UICollectionViewCell {
    static var identifier  = "ProductsOneCell"
    
    
    public var prdimgView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "v6")
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
       
        return iv
    }()
    
    private let prdPriceLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "6,10 TL"
        label.textColor = .black
        label.textAlignment = .left
        
      
        return label
    }()
    
    
    
    private let prdNameLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.text = "Ekmek"
        label.textColor = #colorLiteral(red: 0.2084351075, green: 0.2256772458, blue: 0.2507257898, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 3
      
        return label
    }()
    
    private let addToCartBtn: UIButton = {
       let btn = UIButton(type: .custom)
        btn.setBackgroundImage(UIImage(systemName: "plus"), for: .normal)
        btn.tintColor = .orange
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 15
       
           //btn.addTarget(self, action: #selector(clickAddToCartBtn), for: .touchUpInside)
       return btn
   }()
    
    private let addToFavouriteBtn: UIButton = {
       let btn = UIButton(type: .custom)
        btn.setBackgroundImage(UIImage(named: "likeunselected"), for: .normal)
        btn.clipsToBounds = true
        btn.tintColor = .black
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 15
        
       
       //btn.addTarget(self, action: #selector(clickFavouriteBtn), for: .touchUpInside)
       return btn
   }()
    
    private lazy var prdstackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [prdPriceLbl, prdNameLbl])
        stackView.axis = .vertical
        //stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
        customStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
    
    private func setupViews(){
        addSubview(prdimgView)
        addSubview(prdstackView)
        addSubview(prdNameLbl)
        addSubview(addToCartBtn)
        addSubview(addToFavouriteBtn)
    }
    
    private func customStyle(){
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 0.7
        
        addToCartBtn.layer.shadowOpacity = 12
        addToCartBtn.layer.shadowRadius = 12
        addToCartBtn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
    }
    
}


//MARK: - FillData
extension ProductsOneCell {
    func fillData(product: ProductModel) {
        if let prdImgUrl = URL(string: product.imageUrl) {
            prdimgView.kf.setImage(with: prdImgUrl)
        }
        self.prdNameLbl.text = product.name
        self.prdPriceLbl.text = "\(product.price) TL"
    }
}

//MARK: -
extension ProductsOneCell {
    private func setConstraints(){
        prdimgView.anchor(top: contentView.topAnchor,
                       leading: contentView.leadingAnchor,
                       bottom: nil,
                       trailing: contentView.trailingAnchor,
                       size: .init(width: 0, height: self.frame.height / 1.4 ))
        
        prdstackView.anchor(top: prdimgView.bottomAnchor,
                            leading: leadingAnchor,
                            bottom: bottomAnchor,
                            trailing: trailingAnchor)
        prdPriceLbl.anchor(top: prdimgView.bottomAnchor,
                           leading: prdstackView.leadingAnchor,
                           bottom: nil,
                           trailing: prdstackView.trailingAnchor,
                           padding: .init(top: -52, left: 4, bottom: 0, right: 0))
                           
        prdNameLbl.anchor(top: prdPriceLbl.bottomAnchor,
                          leading: prdstackView.leadingAnchor,
                          bottom: nil,
                          trailing: prdstackView.trailingAnchor,
                          padding: .init(top: -55, left: 4, bottom: 0, right: 0))
        
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

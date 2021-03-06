//
//  ProductsTwoCell.swift
//  ShoppingApp
//
//  Created by ugur-pc on 24.05.2022.
//

import UIKit
import Kingfisher

class ProductsTwoCell: UICollectionViewCell {
    static var identifier = "ProductsTwoCell"
    var addFavClosure: VoidClosure?
    var addToCartClosure: ( () -> Void )?
    
    
    public var prdimgView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "v6")
        iv.contentMode = .scaleAspectFill
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
        label.textColor = #colorLiteral(red: 0.1709887727, green: 0.1870856636, blue: 0.2076978542, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 2
      
        return label
    }()
    
    private var addToCartBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setBackgroundImage(UIImage(systemName: "plus"), for: .normal)
        btn.tintColor = #colorLiteral(red: 0.3803921569, green: 0.01568627451, blue: 0.3725490196, alpha: 1)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 15
        btn.addTarget(self, action: #selector(clickAddToCartBtn), for: .touchUpInside)
       
       return btn
   }()
    
    private let addToFavouriteBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setBackgroundImage(UIImage(named: "likeunselected"), for: .normal)
        btn.tintColor = .black
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 9
        btn.addTarget(self, action: #selector(clickFavouriteBtn), for: .touchUpInside)
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
        contentView.layer.borderColor = UIColor.darkGray.cgColor
        contentView.layer.borderWidth = 0.4
        contentView.layer.cornerRadius = 12
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 3
        self.layer.shadowPath = CGPath.init(rect: CGRect.init(x: 0,
                                                              y: 0,
                                                              width: layer.bounds.width,
                                                              height: layer.bounds.height / 1.46 ),transform: nil)
        self.layer.shadowOpacity = 2;
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        addToCartBtn.layer.shadowOpacity = 12
        addToCartBtn.layer.shadowRadius = 12
        addToCartBtn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
    
}
//MARK: - @objc funcs
extension ProductsTwoCell {
    @objc func clickFavouriteBtn(){
        if let action = self.addFavClosure {
            action()
        }
    }
    
    @objc func clickAddToCartBtn(){
        if let addCartAction = addToCartClosure {
            addToCartBtn.shakeButton()
            addCartAction()
        }
    }
}

//MARK: -  CART
extension ProductsTwoCell {
    func  checkPrdAndCartItem(clickedPrd: ProductModel, allCartItems: [CartModel]){
        var count = 0
        var miktar = 0
        allCartItems.forEach({
            
            if clickedPrd.id == $0.prdId {
                count += 1
                miktar = $0.quantity
                return
            }
        })
        
        if count == 1 {
            userService.addToCart(count: miktar + 1,product: clickedPrd)
        } else {
            userService.addToCart(count: 1,product: clickedPrd)
        
        }
    }
}

//MARK: - Fill Data
extension ProductsTwoCell {
    func fillData(product: ProductModel) {
        if let prdImgUrl = URL(string: product.imageUrl) {
            let placeholder = UIImage(named: "placeholder")
            let options: KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.8))]
            prdimgView.kf.indicatorType = .activity
            prdimgView.kf.setImage(with: prdImgUrl, placeholder: placeholder, options: options)
        }
        self.prdNameLbl.text = product.name
        self.prdPriceLbl.text = "\(numberFormat(product.price)) TL"
        
        // FAV BTN SETTINGS 
        if userService.favourites.contains(product){
            addToFavouriteBtn.tintColor = #colorLiteral(red: 0.8946131468, green: 0.03607716784, blue: 0.3753002882, alpha: 1)
            addToFavouriteBtn.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            addToFavouriteBtn.setBackgroundImage(UIImage(named: "likeunselected"), for: .normal)
            //addToFavouriteBtn.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        }
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
                           padding: .init(top: 8, left: 8, bottom: 0, right: 0))

        prdNameLbl.anchor(top: prdPriceLbl.bottomAnchor,
                          leading: leadingAnchor,
                          bottom: nil,
                          trailing: trailingAnchor,
                          padding: .init(top: 3, left: 8, bottom: 2, right: 0))
        
        addToCartBtn.anchor(top: nil,
                            leading: nil,
                            bottom: prdimgView.bottomAnchor,
                            trailing: prdimgView.trailingAnchor,
                            padding: .init(top: 0, left:0, bottom: 4, right: 1 ),
                            size: .init(width: 37, height: 37))
        
        addToFavouriteBtn.anchor(top: prdimgView.topAnchor,
                                 leading: nil,
                                 bottom: nil,
                                 trailing: prdimgView.trailingAnchor,
                                 padding: .init(top: 10, left:0, bottom: 0, right: 10 ),
                                 size: .init(width: 30, height: 30))
    }
}

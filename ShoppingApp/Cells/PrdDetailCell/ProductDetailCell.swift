//
//  ProductDetailCell.swift
//  ShoppingApp
//
//  Created by ugur-pc on 26.05.2022.
//

import UIKit
import Kingfisher

class ProductDetailCell: UICollectionViewCell {
    static var identifier =  "ProductDetailCell"
    var prdDetailArr: ProductModel?
    var addToCartClosure: VoidClosure?
    
    let colorOne: UIColor = #colorLiteral(red: 0.9529411793, green: 0.4504883169, blue: 0.09692602899, alpha: 1)
    let colorTwo: UIColor = #colorLiteral(red: 0.1414878297, green: 0.6880354557, blue: 0.5711142574, alpha: 0.9887210265)
    let colorThree: UIColor = #colorLiteral(red: 0.4158273037, green: 0.763119476, blue: 0.2118647997, alpha: 1)
    var doublePrice: Double = 0.0
    
    public var prdimgView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 5
       
        return iv
    }()
    
    private let prdPriceLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.text = "102.500.000 TL"
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    
    private let prdTitleLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.text = "Lorem Ipsum"
        label.textColor = #colorLiteral(red: 0.1709887727, green: 0.1870856636, blue: 0.2076978542, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 0
      
        return label
    }()
    
    private let prdDescriptionLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = #colorLiteral(red: 0.1709887727, green: 0.1870856636, blue: 0.2076978542, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
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
    
    private var addBasketBtn: UIButton = {
        let buton = UIButton(type: .system)
         buton.setTitle("Add To Cart", for: .normal)
         buton.backgroundColor = UIColor(red: 197/255, green: 33/255, blue: 52/255, alpha: 1)
         buton.setTitleColor(.white, for: .normal)
         buton.layer.cornerRadius = 15
         buton.layer.masksToBounds = true
         buton.titleLabel?.font = .systemFont(ofSize: 21, weight: .bold)
         buton.addTarget(self, action: #selector(clickAddBasketBtn), for: .touchUpInside)
         return buton
     }()
    
    private let cartIcon: UIImageView = {
           let iv = UIImageView()
           iv.image = UIImage(systemName: "cart")?.withRenderingMode(.alwaysTemplate)
           iv.tintColor = .white
           return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bringSubviewToFront(contentView)
        setupViews()
        setConstraints()
        setupStyle()
    }
    
    private func setupViews(){
        addSubview(prdimgView)
        addSubview(prdTitleLbl)
        addSubview(prdDescriptionLbl)
        addSubview(addBasketBtn)
        addSubview(cartIcon)
    }
    
    private func setupStyle(){
        
        self.addBasketBtn.applyGradient(colors: [colorOne.cgColor, colorTwo.cgColor, colorThree.cgColor])
       
    }
    
    @objc func clickAddBasketBtn(){
        addBasketBtn.shakeButton()
        if let addCartAction = addToCartClosure {
            addCartAction()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
    
   
}

//MARK: -
extension ProductDetailCell {
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
extension ProductDetailCell {
    func configure(objModel: ProductModel) {
        self.prdDetailArr = objModel
        if let prdImgUrl = URL(string: objModel.imageUrl) {
            let placeholder = UIImage(named: "placeholder")
            let options: KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.8))]
            prdimgView.kf.indicatorType = .activity
            prdimgView.kf.setImage(with: prdImgUrl, placeholder: placeholder, options: options)
        }
        self.prdTitleLbl.text = objModel.name
        self.prdDescriptionLbl.text = objModel.productOverview
        
        let strCast = "\(objModel.price)"
        let addCartStr = "Add To Cart | "
        
        let str = NSMutableAttributedString(string: "\(addCartStr)\(objModel.price) TL")
        str.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 27), range: NSMakeRange(0, addCartStr.count))
        str.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 19), range: NSMakeRange(addCartStr.count, strCast.count + 3))
        self.addBasketBtn.setAttributedTitle(str, for: .normal)
    }
    
}

//MARK: -
extension ProductDetailCell {
    private func setConstraints(){
        prdimgView.anchor(top: topAnchor,
                          leading: leadingAnchor,
                          bottom: nil,
                          trailing: trailingAnchor,
                          size: .init(width: contentView.frame.width,
                                      height: 400))
        
        prdTitleLbl.anchor(top: prdimgView.bottomAnchor,
                           leading: leadingAnchor,
                           bottom: prdDescriptionLbl.topAnchor,
                           trailing: trailingAnchor,
                           padding: .init(top: 15, left: 20, bottom: 10, right: 15)
                           )
        
        
        prdDescriptionLbl.anchor(top: prdTitleLbl.bottomAnchor,
                                 leading: leadingAnchor,
                                 bottom: nil,
                                 trailing: trailingAnchor,
                                 padding: .init(top: 7, left: 20, bottom: 15, right: 15))
    
                            
        addBasketBtn.anchor(top: prdDescriptionLbl.bottomAnchor,
                          leading: leadingAnchor,
                          bottom: bottomAnchor,
                          trailing: trailingAnchor,
                          padding: .init(top: 15, left: 15, bottom: 13, right: 15),
                          size: .init(width: 0, height: 60))
       
        
        cartIcon.anchor(top: addBasketBtn.topAnchor,
                        leading: leadingAnchor,
                        bottom: nil,
                        trailing: nil,
                        padding: .init(top: 15, left: 25, bottom: 0, right: 0),
                        size: .init(width: 30, height: 30))
        
   
    }
}

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
    var addFavClosure: VoidClosure?
    var addToCartClosure: ( (Int) -> Void )?
    var prdCount = 0
    
    
    public var prdimgView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
       
        return iv
    }()
    
    private let prdPriceLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .bold)
        label.text = "6,10 TL"
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let prdNameLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.text = "Ekmek"
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
        btn.addTarget(self, action: #selector(clickAddToCartBtn), for: .touchUpInside)
       
       return btn
   }()
    
    private let addToFavouriteBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setBackgroundImage(UIImage(named: "likeunselected"), for: .normal)
        btn.tintColor = .black
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 8
       btn.addTarget(self, action: #selector(clickFavouriteBtn), for: .touchUpInside)
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
        bringSubviewToFront(addToCartBtn)
        bringSubviewToFront(addToFavouriteBtn)
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
        contentView.layer.borderColor = UIColor.darkGray.cgColor
        contentView.layer.borderWidth = 0.8
        contentView.layer.cornerRadius = 12
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 9
        self.layer.shadowPath = CGPath.init(rect: CGRect.init(x: 0,
                                                              y: 0,
                                                              width: layer.bounds.width,
                                                              height: layer.bounds.height / 1.46 ),
                                            transform: nil)
        self.layer.shadowOpacity = 6.0;
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        addToCartBtn.layer.shadowOpacity = 12
        addToCartBtn.layer.shadowRadius = 12
        addToCartBtn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
     
    }
    
}

//MARK: - @objc funcs
extension ProductsOneCell {
    @objc func clickFavouriteBtn(){
        if let action = addFavClosure  {        // add fav when click then homevc shown
            action()
        }
    }
    @objc func clickAddToCartBtn(){
        if let addCartAction = addToCartClosure {
           
            prdCount += 1
            print("myprd", prdCount)

            addCartAction(prdCount)
        }
    }
}


//MARK: - FillData
extension ProductsOneCell {
    func fillData(product: ProductModel) { 
        if let prdImgUrl = URL(string: product.imageUrl) {
            let placeholder = UIImage(named: "placeholder")
            let options: KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.8))]
            prdimgView.kf.indicatorType = .activity
            prdimgView.kf.setImage(with: prdImgUrl, placeholder: placeholder, options: options)
        }
        self.prdNameLbl.text = product.name
        self.prdPriceLbl.text = "\(product.price) TL"
        
        // FAV BTN SETTINGS
        if userService.favourites.contains(product){
            //addToFavouriteBtn.setBackgroundImage(UIImage(named: "likefillselected"), for: .normal)
            addToFavouriteBtn.tintColor = #colorLiteral(red: 0.8946131468, green: 0.03607716784, blue: 0.3753002882, alpha: 1)
            addToFavouriteBtn.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            addToFavouriteBtn.setBackgroundImage(UIImage(named: "likeunselected"), for: .normal)
            //addToFavouriteBtn.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        }
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
                           padding: .init(top: -52, left: 6, bottom: 0, right: 0))
                           
        prdNameLbl.anchor(top: prdPriceLbl.bottomAnchor,
                          leading: prdstackView.leadingAnchor,
                          bottom: nil,
                          trailing: prdstackView.trailingAnchor,
                          padding: .init(top: -55, left: 6, bottom: 0, right: 0))
        
        addToCartBtn.anchor(top: nil,
                            leading: nil,
                            bottom: prdimgView.bottomAnchor,
                            trailing: prdimgView.trailingAnchor,
                            padding: .init(top: 0, left:0, bottom: 12, right: 10 ),
                            size: .init(width: 40, height: 40))
        
        addToFavouriteBtn.anchor(top: prdimgView.topAnchor,
                                 leading: nil,
                                 bottom: nil,
                                 trailing: prdimgView.trailingAnchor,
                                 padding: .init(top: 10, left:0, bottom: 0, right: 10 ),
                                 size: .init(width: 28, height: 28))
    }
}

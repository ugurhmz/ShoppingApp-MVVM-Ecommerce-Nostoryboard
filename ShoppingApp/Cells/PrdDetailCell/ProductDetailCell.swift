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
    var myClosure: ( (Int) -> Void )?
    
    var prdCount = 1
    let colorOne: UIColor = #colorLiteral(red: 0.9529411793, green: 0.4504883169, blue: 0.09692602899, alpha: 1)
    let colorTwo: UIColor = #colorLiteral(red: 0.1414878297, green: 0.6880354557, blue: 0.5711142574, alpha: 0.9887210265)
    let colorThree: UIColor = #colorLiteral(red: 0.4158273037, green: 0.763119476, blue: 0.2118647997, alpha: 1)
    var getObjPrice: Double = 0.0
    
    public var prdimgView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 5
       
        return iv
    }()
    
    private let prdPriceLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23, weight: .bold)
        label.text = "102.500.000 TL"
        label.textColor = .black
        label.textAlignment = .center
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
    
    private let plusBtn: UIButton = {
         let buton = UIButton()
         buton.setTitle("+", for: .normal)
         buton.backgroundColor = UIColor(red: 197/255, green: 33/255, blue: 52/255, alpha: 1)
         buton.setTitleColor(.white, for: .normal)
         buton.layer.cornerRadius = 15
         buton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
         
         buton.addTarget(self, action: #selector(clickPlusBtn), for: .touchUpInside)
         return buton
     }()
    
    private var minusBtn: UIButton = {
        let buton = UIButton(type: .system)
         buton.setTitle("-", for: .normal)
         buton.backgroundColor = UIColor(red: 197/255, green: 33/255, blue: 52/255, alpha: 1)
         buton.setTitleColor(.white, for: .normal)
         buton.layer.cornerRadius = 15
         buton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
         buton.addTarget(self, action: #selector(clickMinusBtn), for: .touchUpInside)
         return buton
     }()
    
    private let stepperCountLbl: UILabel = {
          let label = UILabel()
          label.font = .systemFont(ofSize: 18, weight: .bold)
          label.text = "1"
          label.textColor = .black
          label.textAlignment = .center
          
          return label
   }()
    
    private var  prdstackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var addBasketBtn: UIButton = {
        let buton = UIButton(type: .system)
         buton.setTitle("Add To Cart", for: .normal)
         buton.backgroundColor = UIColor(red: 197/255, green: 33/255, blue: 52/255, alpha: 1)
         buton.setTitleColor(.white, for: .normal)
         buton.layer.cornerRadius = 15
         buton.layer.masksToBounds = true
         buton.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
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
        addSubview(prdstackView)
        [minusBtn, stepperCountLbl, plusBtn].forEach{ prdstackView.addArrangedSubview($0)}
        
        addSubview(addBasketBtn)
        addSubview(cartIcon)
        addSubview(prdPriceLbl)
    }
    
    private func setupStyle(){
        
        self.addBasketBtn.applyGradient(colors: [colorOne.cgColor, colorTwo.cgColor, colorThree.cgColor])
        self.plusBtn.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.453745815, blue: 0.06696524085, alpha: 0.9476407285)
        self.minusBtn.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.453745815, blue: 0.06696524085, alpha: 0.9476407285)
        
        self.myClosure = { [weak self] myPrdCount in
            guard let self = self else { return }
            self.stepperCountLbl.text = "\(myPrdCount)"
            let totalPrice = self.getObjPrice * Double(myPrdCount)
            self.prdPriceLbl.text = "\(Double(round(1000*totalPrice)/1000)) TL"
            
            NotificationCenter.default.post(name: NSNotification.Name("applyBtn"), object: myPrdCount)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
    
   
}

//MARK: - Fill Data
extension ProductDetailCell {
    func configure(objModel: ProductModel) {
        if let prdImgUrl = URL(string: objModel.imageUrl) {
            let placeholder = UIImage(named: "placeholder")
            let options: KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.8))]
            prdimgView.kf.indicatorType = .activity
            prdimgView.kf.setImage(with: prdImgUrl, placeholder: placeholder, options: options)
        }
        self.prdTitleLbl.text = objModel.name
        self.prdDescriptionLbl.text = objModel.productOverview
        self.prdPriceLbl.text = "\(objModel.price) TL"
        self.getObjPrice = objModel.price
    }
    
}

//MARK: - @objc funcs
extension ProductDetailCell {
    @objc func clickMinusBtn(){
        prdCount -= 1
        if prdCount < 1 {
            self.prdCount = 1
        }
        self.myClosure?(prdCount)
    }
    
    @objc func clickPlusBtn(){
        prdCount += 1
        
        if prdCount > 15 {
            self.prdCount = 15
        }
        self.myClosure?(prdCount)
    }
    
    @objc func clickAddBasketBtn(){
        print("addBasket")
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
                                 bottom: prdstackView.topAnchor,
                                 trailing: trailingAnchor,
                                 padding: .init(top: 7, left: 20, bottom: 15, right: 15))
        
        prdstackView.anchor(top: prdDescriptionLbl.bottomAnchor,
                            leading: leadingAnchor,
                            bottom: addBasketBtn.topAnchor,
                            trailing: nil,
                            padding: .init(top: 10, left: 15, bottom: 33, right: 10),
                            size: .init(width: 140, height: 60))
        
                            
        addBasketBtn.anchor(top: prdstackView.bottomAnchor,
                          leading: leadingAnchor,
                          bottom: bottomAnchor,
                          trailing: trailingAnchor,
                          padding: .init(top: 5, left: 25, bottom: 13, right: 25),
                          size: .init(width: 0, height: 60))
       
        
        cartIcon.anchor(top: addBasketBtn.topAnchor,
                        leading: leadingAnchor,
                        bottom: nil,
                        trailing: nil,
                        padding: .init(top: 15, left: 80, bottom: 0, right: 0),
                        size: .init(width: 30, height: 30))
        
        prdPriceLbl.anchor(top: prdDescriptionLbl.bottomAnchor,
                           leading: prdstackView.trailingAnchor,
                           bottom: nil,
                           trailing: prdDescriptionLbl.trailingAnchor,
                           padding: .init(top: 22, left: 40, bottom: 0, right: 0),
                           size: .init(width: 0, height: 0))
    }
}

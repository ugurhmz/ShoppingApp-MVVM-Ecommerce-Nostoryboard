//
//  ProductDetailCell.swift
//  ShoppingApp
//
//  Created by ugur-pc on 26.05.2022.
//

import UIKit

class ProductDetailCell: UICollectionViewCell {
    static var identifier =  "ProductDetailCell"
    
    public var prdimgView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "v6")
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 5
       
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
        label.text = "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentiallyis simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentiallyis simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially "
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
          label.text = "0"
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
    
    private var addCartBtn: UIButton = {
        let buton = UIButton(type: .system)
         buton.setTitle("Add To Cart", for: .normal)
         buton.backgroundColor = UIColor(red: 197/255, green: 33/255, blue: 52/255, alpha: 1)
         buton.setTitleColor(.white, for: .normal)
         buton.layer.cornerRadius = 15
         buton.layer.masksToBounds = true
         buton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
         buton.addTarget(self, action: #selector(clickMinusBtn), for: .touchUpInside)
         return buton
     }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bringSubviewToFront(contentView)
        setupViews()
        setConstraints()
    }
    
    private func setupViews(){
        addSubview(prdimgView)
        addSubview(prdTitleLbl)
        addSubview(prdDescriptionLbl)
        addSubview(prdstackView)
        [minusBtn, stepperCountLbl, plusBtn].forEach{ prdstackView.addArrangedSubview($0)}
        
        addSubview(addCartBtn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
}


//MARK: - @objc funcs
extension ProductDetailCell {
    @objc func clickMinusBtn(){
        print("-")
    }
    
    @objc func clickPlusBtn(){
        print("+")
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
                           padding: .init(top: 15, left: 10, bottom: 10, right: 10)
                           )
        
        
        prdDescriptionLbl.anchor(top: prdTitleLbl.bottomAnchor,
                                 leading: leadingAnchor,
                                 bottom: prdstackView.topAnchor,
                                 trailing: trailingAnchor,
                                 padding: .init(top: 7, left: 10, bottom: 15, right: 10))
        
        prdstackView.anchor(top: prdDescriptionLbl.bottomAnchor,
                            leading: leadingAnchor,
                            bottom: addCartBtn.topAnchor,
                            trailing: nil,
                            padding: .init(top: 10, left: 15, bottom: 30, right: 10),
                            size: .init(width: 140, height: 50))
        
                            
        addCartBtn.anchor(top: prdstackView.bottomAnchor,
                          leading: leadingAnchor,
                          bottom: bottomAnchor,
                          trailing: trailingAnchor,
                          padding: .init(top: 10, left: 40, bottom: 10, right: 40),
                          size: .init(width: 0, height: 60)
                          
        )
    }
}

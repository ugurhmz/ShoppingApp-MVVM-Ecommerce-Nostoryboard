//
//  CartTableCell.swift
//  ShoppingApp
//
//  Created by ugur-pc on 27.05.2022.
//

import UIKit

class CartCollectionCell: UICollectionViewCell {
    
    static var identifier = "CartCollectionCell"
    var myClosure: ( (Int) -> Void )?
    var prdCount = 1
    var getObjPrice: Double = 0.0
    
    private let prdImgView: UIImageView = {
         let iv = UIImageView()
         iv.image = UIImage(named: "v3")
         iv.contentMode = .scaleAspectFill
         iv.clipsToBounds = true
         iv.layer.cornerRadius = 15
         return iv
    }()
    
    private let prdPriceLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "1020.50 TL"
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let prdTitleLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 21, weight: .bold)
        label.text = "Lorem Ipsum"
        label.textColor = #colorLiteral(red: 0.1709887727, green: 0.1870856636, blue: 0.2076978542, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 0

        return label
    }()

    private let prdDescriptionLbl: UILabel = {
        let label = UILabel()
        label.text = "lorem ipsum dolar sit lorem ipsum dolar sitlorem ipsum dolar sitlorem ipsum dolar sitlorem ipsum dolar sit"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = #colorLiteral(red: 0.1709887727, green: 0.1870856636, blue: 0.2076978542, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
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
    private let deleteIcon: UIImageView = {
           let iv = UIImageView()
           iv.image = UIImage(systemName: "trash")?.withRenderingMode(.alwaysTemplate)
           iv.tintColor = .red
           return iv
    }()

    private var  topstackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        return stackView
    }()


    private var  prdstackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
        setStyle()
    }
    
    private func setStyle(){
        self.plusBtn.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.453745815, blue: 0.06696524085, alpha: 0.9476407285)
        self.minusBtn.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.453745815, blue: 0.06696524085, alpha: 0.9476407285)
        bringSubviewToFront(prdstackView)
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

//MARK: - @objc funcs
extension CartCollectionCell {
    
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
}

//MARK: -
extension CartCollectionCell {
    
    private func setupViews(){
        addSubview(prdImgView)
        addSubview(deleteIcon)
        addSubview(prdstackView)
        addSubview(topstackView)
        addSubview(prdPriceLbl)
        [minusBtn, stepperCountLbl, plusBtn].forEach{ prdstackView.addArrangedSubview($0)}
        [prdTitleLbl, prdDescriptionLbl].forEach{ topstackView.addArrangedSubview($0)}
        
    }
    
    private func setConstraints(){
        prdImgView.anchor(top: contentView.topAnchor,
                          leading: contentView.leadingAnchor,
                          bottom: bottomAnchor,
                          trailing: nil,
                          size: .init(width: 120, height: 0))
        
        deleteIcon.anchor(top: topstackView.topAnchor,
                          leading: nil,
                          bottom: nil,
                          trailing: topstackView.trailingAnchor,
                          padding: .init(top: 2, left: 6, bottom: 10, right: 2),
                          size: .init(width: 0, height: 20))
        
        
        topstackView.anchor(top: topAnchor,
                            leading: prdImgView.trailingAnchor,
                            bottom: nil,
                            trailing: trailingAnchor,
                            padding: .init(top: 2, left: 8, bottom: 0, right: 0),
                            size: .init(width: 0, height: 80))
        
        prdstackView.anchor(top: topstackView.bottomAnchor,
                            leading: prdImgView.trailingAnchor,
                           bottom: bottomAnchor,
                           trailing: nil,
                           padding: .init(top: 2, left: 8, bottom: 5, right: 10),
                           size: .init(width: 100, height: 0))
        
        prdPriceLbl.anchor(top: topstackView.bottomAnchor,
                          leading: prdstackView.trailingAnchor,
                          bottom: bottomAnchor,
                          trailing: trailingAnchor,
                          padding: .init(top: 2, left: 5, bottom: 5, right: 1))
    }
}




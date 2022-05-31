//
//  ProductsByCategoryCell.swift
//  ShoppingApp
//
//  Created by ugur-pc on 30.05.2022.
//

import UIKit
import Kingfisher

class ProductsByCategoryCell: UICollectionViewCell {
    static var identifier = "ProductsByCategoryCell"
    var homeViewModel = HomeViewModel()
   
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
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "Price : 1020.50 TL"
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private let prdTitleLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.text = "Lorem Ipsum"
        label.textColor = #colorLiteral(red: 0.1709887727, green: 0.1870856636, blue: 0.2076978542, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 2

        return label
    }()

    private let prdDescriptionLbl: UILabel = {
        let label = UILabel()
        label.text = "lorem ipsum dolar sit lorem ipsum dolar sitlorem ipsum dolar sitlorem ipsum dolar sitlorem ipsum dolar sit"
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = #colorLiteral(red: 0.1709887727, green: 0.1870856636, blue: 0.2076978542, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
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
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.alignment =  .leading
        stackView.distribution = .fillEqually
        return stackView
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension ProductsByCategoryCell {
    func fillData(data: ProductModel){
        self.prdTitleLbl.text = data.name
        
        if let prdImgUrl = URL(string: data.imageUrl) {
            let placeholder = UIImage(named: "placeholder")
            let options: KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.8))]
            prdImgView.kf.indicatorType = .activity
            prdImgView.kf.setImage(with: prdImgUrl, placeholder: placeholder, options: options)
        }
        self.prdTitleLbl.text = data.name
        self.prdDescriptionLbl.text = data.productOverview
        self.prdPriceLbl.text = "Price: \(data.price) TL"
    }
}

//MARK: -
extension ProductsByCategoryCell {
    
    private func setupViews(){
        addSubview(prdImgView)
        addSubview(topstackView)
        addSubview(prdstackView)
        addSubview(prdPriceLbl)
        [prdTitleLbl, prdDescriptionLbl].forEach{ topstackView.addArrangedSubview($0)}
        [prdPriceLbl].forEach{ prdstackView.addArrangedSubview($0)}
        
    }
    
    private func setConstraints(){
        prdImgView.anchor(top: contentView.topAnchor,
                          leading: contentView.leadingAnchor,
                          bottom: bottomAnchor,
                          trailing: nil,
                          size: .init(width: 120, height: 0))
        
        topstackView.anchor(top: topAnchor,
                            leading: prdImgView.trailingAnchor,
                            bottom: nil,
                            trailing: trailingAnchor,
                            padding: .init(top: 20, left: 8, bottom: 0, right: 8),
                            size: .init(width: 0, height: 80))
        prdstackView.anchor(top: topstackView.bottomAnchor,
                            leading: prdImgView.trailingAnchor,
                           bottom: bottomAnchor,
                           trailing: trailingAnchor,
                           padding: .init(top: 5, left: 8, bottom: 2, right: 10))
    }
}



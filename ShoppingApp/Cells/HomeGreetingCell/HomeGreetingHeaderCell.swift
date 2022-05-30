//
//  HomeGreetingHeaderCell.swift
//  ShoppingApp
//
//  Created by ugur-pc on 30.05.2022.
//

import UIKit
import Firebase

class HomeGreetingHeaderCell: UICollectionViewCell {
    static var identifier = "HomeGreetingHeaderCell"
    
    public var personImg: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "carton")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 20
        return iv
    }()

    private let headerLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Zapfino", size: 25)
        let myShadow = NSShadow()
        myShadow.shadowBlurRadius = 3
        myShadow.shadowOffset = CGSize(width: 3, height: 3)
        myShadow.shadowColor = UIColor.gray
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(headerLbl)
        addSubview(personImg)
        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.cornerRadius = 20
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -
extension HomeGreetingHeaderCell {
    func userInfo(data: String) {
        if let splitEmail = data.split(separator: "@", maxSplits: 1).map(String.init).first {
            self.headerLbl.text = "Hi \(splitEmail)"
        }
    }
}

//MARK: -
extension HomeGreetingHeaderCell {
    private func setConstraints(){
        
        personImg.anchor(top: topAnchor,
                         leading: nil,
                         bottom: nil,
                         trailing: trailingAnchor,
                         padding: .init(top: -40, left: 2, bottom: 0, right: -5),
                         size: .init(width: 120, height: 190)
        )
        
        headerLbl.anchor(top: topAnchor,
                         leading: leadingAnchor,
                         bottom: bottomAnchor,
                         trailing: personImg.leadingAnchor,
                         padding: .init(top: 15, left: 15, bottom: 5, right: 15))
    }
}

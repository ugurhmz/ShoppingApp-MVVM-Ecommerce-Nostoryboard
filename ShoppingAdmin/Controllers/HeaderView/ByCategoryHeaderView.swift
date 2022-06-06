//
//  ByCategoryHeaderView.swift
//  ShoppingAdmin
//
//  Created by ugur-pc on 29.05.2022.
//

import UIKit

class ByCategoryHeaderView: UICollectionReusableView {
    
    static var identifier = "ByCategoryHeaderView"
    
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
        label.font = UIFont(name: "Zapfino", size: 32)
        label.text = "Merhaba Admin"
        let myShadow = NSShadow()
        myShadow.shadowBlurRadius = 3
        myShadow.shadowOffset = CGSize(width: 3, height: 3)
        myShadow.shadowColor = UIColor.gray
        
        let myString = "Hi Admin"
        let myAttribute = [
            NSAttributedString.Key.shadow: myShadow,
            NSAttributedString.Key.foregroundColor: UIColor.black,
                            NSAttributedString.Key.font: UIFont(name: "Zapfino", size: 32.0)! ]
        let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)

        // set attributed text on a UILabel
        label.attributedText = myAttrString
        
        
        label.textColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let headerDescriptionLbl: UILabel = {
        let label = UILabel()
        let myShadow = NSShadow()
        myShadow.shadowBlurRadius = 3
        myShadow.shadowOffset = CGSize(width: 3, height: 3)
        myShadow.shadowColor = UIColor.lightGray
        
        let myString = "Total Categories: 100"
        let myAttribute = [
            NSAttributedString.Key.shadow: myShadow,
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1),
                            NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 24.0)! ]
        let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)

        // set attributed text on a UILabel
        label.attributedText = myAttrString
        label.textAlignment = .left
        label.numberOfLines = 0
        //label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(headerLbl)
        addSubview(headerDescriptionLbl)
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
extension ByCategoryHeaderView {
    func fillCategoryData(category: [CategoryModel]) {
        self.headerDescriptionLbl.text = "Total Categories: \(category.count)"
    }
}

//MARK: -
extension ByCategoryHeaderView {
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
                         bottom: nil,
                         trailing: personImg.leadingAnchor,
                         padding: .init(top: 25, left: 15, bottom: 0, right: 15),
                         size: .init(width: 0, height: 90)
        )
        headerDescriptionLbl.anchor(top: headerLbl.bottomAnchor,
                                    leading: leadingAnchor,
                                    bottom: bottomAnchor,
                                    trailing: trailingAnchor,
                                    padding: .init(top: 29, left: 15, bottom: 10, right: 8) )
    }
}

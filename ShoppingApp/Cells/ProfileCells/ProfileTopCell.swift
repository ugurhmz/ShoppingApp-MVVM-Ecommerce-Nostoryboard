//
//  ProfileTopCell.swift
//  ShoppingApp
//
//  Created by ugur-pc on 4.06.2022.
//

import UIKit
import Firebase
class ProfileTopCell: UICollectionViewCell {
    static var identifier = "ProfileTopCell"
    
    
    private let userImgView: UIImageView = {
         let iv = UIImageView()
         iv.image = UIImage(named: "ugur")
         iv.contentMode = .scaleToFill
         iv.clipsToBounds = true
         iv.layer.cornerRadius = 15
         iv.layer.borderWidth = 0.3
         return iv
    }()
    
    private let usernameLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .bold)
        label.text = "User: "
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let userCreatedLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.text = "Created Time: "
        label.textColor = #colorLiteral(red: 0.1709887727, green: 0.1870856636, blue: 0.2076978542, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 2
      
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [usernameLbl, userCreatedLbl])
        stackView.axis = .vertical
        //stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    private func setupViews(){
        addSubview(userImgView)
        addSubview(stackView)
  
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
}

extension ProfileTopCell {
    
    func configure(user: User) {
        if let email = user.email {
            self.usernameLbl.text = "E-mail: \(email)"
        }
        
        if let creationUsr = user.metadata.creationDate {
            self.userCreatedLbl.text = "Creation: \(creationUsr)"
        }
    }
}

//MARK: -
extension ProfileTopCell {
    private func setConstraints(){
        userImgView.anchor(top: contentView.topAnchor,
                           leading: nil,
                           bottom: nil,
                           trailing: nil,
                           size: .init(width: 200, height: 200)
        )
        userImgView.centerXInSuperview()
        
        stackView.anchor(top: userImgView.bottomAnchor,
                         leading: contentView.leadingAnchor,
                         bottom: contentView.bottomAnchor,
                         trailing: contentView.trailingAnchor,
                         padding: .init(top: 0, left: 20, bottom: 20, right: 20)
        )
    }
}

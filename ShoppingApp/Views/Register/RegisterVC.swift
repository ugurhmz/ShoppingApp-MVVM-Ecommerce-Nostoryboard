//
//  RegisterVC.swift
//  ShoppingApp
//
//  Created by ugur-pc on 20.05.2022.
//

import UIKit

class RegisterVC: UIViewController {
    
    private let myview: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let personImgView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "person.crop.circle.badge.plus")
        iv.tintColor = .white
        return iv
    }()
    
    private let registerTxtLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont(name: "Zapfino", size: 32)
        label.text = "Register"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let txtUsername: CustomTextField = {
        let txt = CustomTextField(padding: 24, height: 55)
        txt.backgroundColor = .white
        txt.placeholder = "Username"
        txt.layer.borderWidth = 1
        return txt
    }()
    
    private let txtEmail: CustomTextField = {
        let txt = CustomTextField(padding: 24, height: 55)
        txt.backgroundColor = .white
        txt.keyboardType = .emailAddress
        txt.placeholder = "Email address"
        txt.layer.borderWidth = 1
        return txt
    }()
    
    private let txtPassword: CustomTextField = {
        let txt = CustomTextField(padding: 24, height: 55)
        txt.backgroundColor = .white
        txt.isSecureTextEntry = true
        txt.placeholder = "Password"
        txt.layer.borderWidth = 1
        return txt
    }()
    
    private let txtRePassword: CustomTextField = {
        let txt = CustomTextField(padding: 24, height: 55)
        txt.backgroundColor = .white
        txt.isSecureTextEntry = true
        txt.placeholder = "Re password"
        txt.layer.borderWidth = 1
        return txt
    }()
    
    private let registerBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Register", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 15
        btn.backgroundColor = UIColor(red: 16/255, green: 129/255, blue: 49/255, alpha: 1)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor(red: 16/255, green: 129/255, blue: 49/255, alpha: 1).cgColor
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        return btn
    }()
    
    
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [registerTxtLabel,txtUsername,txtEmail, txtPassword,txtRePassword, registerBtn ])
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        setupViews()
        setConstraints()
    }
    
}

//MARK: -
extension RegisterVC {
    private func setupViews(){
        view.addSubview(myview)
        view.addSubview(stackView)
        view.addSubview(personImgView)
        myview.layer.cornerRadius = 50
        myview.clipsToBounds = true
        myview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setConstraints(){
        myview.anchor(top: view.topAnchor,
                      leading: view.leadingAnchor,
                      bottom: view.bottomAnchor,
                      trailing: view.trailingAnchor,
                      padding: .init(top: 200, left: 0, bottom: 0, right: 0))
        
        stackView.anchor(top: nil,
                         leading: view.leadingAnchor,
                         bottom: nil,
                         trailing: view.trailingAnchor,
                         padding: .init(top: 0, left: 30, bottom: 0, right: 30))
        stackView.centerYInSuperview()
        
        personImgView.anchor(top: view.topAnchor,
                              leading: nil,
                             bottom: myview.topAnchor,
                              trailing: nil,
                              padding: .init(top: 20, left: 0, bottom: 30, right: 0),
                             size: .init(width: 150, height: 100)
        )
        personImgView.centerXInSuperview()
    }
}

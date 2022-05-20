//
//  LoginVC.swift
//  ShoppingApp
//
//  Created by ugur-pc on 20.05.2022.
//

import UIKit

class LoginVC: UIViewController {
    
    
    private let myview: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
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
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [txtEmail, txtPassword, forgetPwTxtLabel, loginBtn, createNewUserBtn])
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private let personImgView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "arrow.up.and.person.rectangle.portrait")
        iv.tintColor = .white
        return iv
    }()
    
    private let loginTxtLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont(name: "Zapfino", size: 55)
        label.text = "Login"
        label.textColor = .white
        return label
    }()
    
    private let forgetPwTxtLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 21, weight: .medium)
        label.text = "Forgot password?"
        label.textColor = .black
        return label
    }()
    
    private let loginBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Login", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 15
        btn.backgroundColor = .blue
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return btn
    }()
    
    private let createNewUserBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Create new user", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 15
        btn.backgroundColor = .systemGreen
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        return btn
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.addSubview(stackView)
        view.addSubview(myview)
        view.addSubview(personImgView)
        view.addSubview(loginTxtLabel)
        forgetPwTxtLabel.textAlignment = .right
        
        view.backgroundColor = .systemBlue
        view.bringSubviewToFront(stackView)
       
        myview.layer.cornerRadius = 50
        myview.clipsToBounds = true
        myview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}

//MARK: -
extension LoginVC {
    private func setConstraints() {
        stackView.anchor(top: nil,
                         leading: view.leadingAnchor,
                         bottom: nil,
                         trailing: view.trailingAnchor,
                         padding: .init(top: 0, left: 30, bottom: 0, right: 30))
        stackView.centerYInSuperview()
        
        
        myview.anchor(top: view.topAnchor,
                      leading: view.leadingAnchor,
                      bottom: view.bottomAnchor,
                      trailing: view.trailingAnchor,
                      padding: .init(top: 200, left: 0, bottom: 0, right: 0))
        
        personImgView.anchor(top: view.topAnchor,
                             leading: nil,
                             bottom: nil,
                             trailing: view.trailingAnchor,
                             padding: .init(top: 50, left: 50, bottom: 50, right: 10),
                             size: .init(width: 150, height: 100))
        
        loginTxtLabel.anchor(top: view.topAnchor,
                             leading: view.leadingAnchor,
                             bottom: nil,
                             trailing: nil,
                             padding: .init(top: 14, left: 30, bottom: 30, right: 10))
        

    }
}


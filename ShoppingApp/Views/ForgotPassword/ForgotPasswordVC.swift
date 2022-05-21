//
//  ForgotPasswordVC.swift
//  ShoppingApp
//
//  Created by ugur-pc on 21.05.2022.
//

import UIKit
import Firebase

class ForgotPasswordVC: UIViewController {

    
    private let centerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.text = "Please enter your e-mail."
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let emailTextField: CustomTextField = {
        let txt = CustomTextField(padding: 24, height: 55)
        txt.backgroundColor = .white
        txt.placeholder = "Email"
        txt.layer.borderWidth = 1
        return txt
    }()
    
    private let cancelBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Cancel", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 15
        btn.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
       btn.addTarget(self, action: #selector(cancelClickBtn), for: .touchUpInside)
        return btn
    }()
    
    @objc func cancelClickBtn(){
        dismiss(animated: true, completion: nil)
    }
    
    private let resetPasswordBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Reset Password", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 15
        btn.backgroundColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        btn.addTarget(self, action: #selector(clickResetBtn), for: .touchUpInside)
        return btn
    }()
    
    @objc func clickResetBtn(){
        
        guard let email = emailTextField.text, !email.isEmpty else {
            self.createAlert(title: "",
                             msg: "Please enter email.",
                             prefStyle: .alert,
                             bgColor: .white,
                             textColor: .black,
                             fontSize: 25)
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            
            if let error = error {
                print(error.localizedDescription)
                self.handleFireAuthError(error: error, fontSize: 24, textColor: .red, bgColor: .white)
                return
            }
            
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    private lazy var btnstackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cancelBtn ,resetPasswordBtn])
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        
    }
    
    private func setupViews(){
        view.backgroundColor = .black.withAlphaComponent(0.8)
        view.addSubview(centerView)
        view.addSubview(textLabel)
        view.addSubview(emailTextField)
        view.addSubview(btnstackView)
        
        centerView.layer.shadowOpacity = 80
        centerView.layer.shadowRadius =  70
        centerView.layer.shadowColor = UIColor.lightGray.cgColor
    }
    
}

//MARK: -
extension ForgotPasswordVC {
    private func setConstraints(){
        centerView.anchor(top: nil,
                          leading: view.leadingAnchor,
                          bottom: nil,
                          trailing: view.trailingAnchor,
                          padding: .init(top: 0, left: 0, bottom: 0, right: 0),
                          size : .init(width: 0, height: 300)  )
        centerView.centerYInSuperview()
        //centerView.centerXInSuperview()
        
        
        textLabel.anchor(top: centerView.topAnchor,
                         leading: centerView.leadingAnchor,
                         bottom: nil,
                         trailing: centerView.trailingAnchor,
                         padding: .init(top: 20, left: 10, bottom: 0, right: 10),
                         size : .init(width: 0, height: 40)  )
        
        emailTextField.anchor(top: textLabel.bottomAnchor,
                              leading: centerView.leadingAnchor,
                              bottom: nil,
                              trailing: centerView.trailingAnchor,
                              padding: .init(top: 20, left: 10, bottom: 0, right: 10),
                              size : .init(width: 0, height:55)  )
     
        
        btnstackView.anchor(top: emailTextField.bottomAnchor,
                            leading: centerView.leadingAnchor,
                            bottom: nil,
                            trailing: centerView.trailingAnchor,
                            padding: .init(top: 20, left: 5, bottom: 0, right: 5),
                            size : .init(width: 0, height: 45)
        )
    }
}

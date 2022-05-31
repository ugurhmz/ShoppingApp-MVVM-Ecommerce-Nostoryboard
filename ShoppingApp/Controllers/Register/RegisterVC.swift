//
//  RegisterVC.swift
//  ShoppingApp
//
//  Created by ugur-pc on 20.05.2022.
//

import UIKit
import Firebase


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
        label.font =  UIFont(name: "Zapfino", size: 45)
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
        txt.addTarget(self, action: #selector(pwTextDidChange(_:)), for: .editingChanged)
        return txt
    }()
    
    
    private let txtRePassword: CustomTextField = {
        let txt = CustomTextField(padding: 24, height: 55)
        txt.backgroundColor = .white
        txt.isSecureTextEntry = true
        txt.placeholder = "Re password"
        txt.layer.borderWidth = 1
        txt.addTarget(self, action: #selector(pwTextDidChange(_:)), for: .editingChanged)
        return txt
    }()
    
    // Password did change
    @objc func pwTextDidChange(_ textField: UITextField){
        
        guard let passTxt = txtPassword.text else { return }
        
        // typing then check when remove in field
        if textField == txtRePassword {
            checkPaswoordFieldImg.isHidden = false
            checkRePasswordImg.isHidden = false
        } else {
            if passTxt.isEmpty {
                checkPaswoordFieldImg.isHidden = true
                checkRePasswordImg.isHidden = true
                txtRePassword.text = ""
            }
        }
        
        // matching
        if txtPassword.text == txtRePassword.text {
            checkPaswoordFieldImg.tintColor = AppColors.DarkGreen
            checkRePasswordImg.tintColor = AppColors.DarkGreen
        } else {
            checkPaswoordFieldImg.tintColor = .red
            checkRePasswordImg.tintColor = .red
        }
    }
    
    private let registerBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Register", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 15
        btn.backgroundColor = AppColors.DarkGreen
        btn.layer.borderWidth = 1
        btn.layer.borderColor = AppColors.DarkGreen.cgColor
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        btn.addTarget(self, action: #selector(clickRegisterBtn), for: .touchUpInside)
        return btn
    }()
    
    private let checkPaswoordFieldImg: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .red
        return iv
    }()
    
    private let checkRePasswordImg: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .red
        return iv
    }()
  
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [registerTxtLabel,txtUsername,txtEmail, txtPassword,txtRePassword, registerBtn ])
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.DarkGreen
        setupViews()
        setConstraints()
    }
    
}

//MARK: -  AUTHENTICATION
extension RegisterVC {
    
    // click registerBtn
    @objc func clickRegisterBtn(){
        
        guard let email = txtEmail.text, !email.isEmpty,
              let username = txtUsername.text, !username.isEmpty,
              let password = txtPassword.text, !password.isEmpty,
              let rePass = txtRePassword.text, !rePass.isEmpty
              
        else {
                  
                  self.createAlert(title: "",
                                   msg: "Fields can't be empty!",
                                   prefStyle: .alert,
                                   bgColor: .white,
                                   textColor: .black,
                                   fontSize: 25)
                  return
              }
        
        guard let rePassword = txtRePassword.text, rePassword == password else {
            self.createAlert(title: "Error",
                             msg: "Passwords do not match !",
                             prefStyle: .alert,
                             bgColor: .white,
                             textColor: .black,
                             fontSize: 25)
            return
        }
        
        self.showActivityIndicator()
        
//        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
//            if let error = error {
//                print(error.localizedDescription)
//                self.handleFireAuthError(error: error,
//                                    fontSize: 24,
//                                    textColor: #colorLiteral(red: 0.9254902005, green: 0.3018482075, blue: 0.1536569698, alpha: 1),
//                                    bgColor: .white)
//                return
//            }
//
//            guard let fireUser = result?.user else { return }
//            let artUser = UserModel(id: fireUser.uid,
//                                    email: email,
//                                    username: username,
//                                    stripeId: "")
//            // UPLOAD FIRESTORE
//            self.createFireStoreUser(user: artUser)
//
        //}
        
        
        guard let authUser = Auth.auth().currentUser else {
            return
        }

        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        
        authUser.link(with: credential) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
                self.handleFireAuthError(error: error,
                                    fontSize: 24,
                                    textColor: #colorLiteral(red: 0.9254902005, green: 0.3018482075, blue: 0.1536569698, alpha: 1),
                                    bgColor: .white)
                return
            }

            guard let fireUser = result?.user else { return }
            let artUser = UserModel(id: fireUser.uid,
                                    email: email,
                                    username: username,
                                    stripeId: "")
            // UPLOAD FIRESTORE
            self.createFireStoreUser(user: artUser)
        }
    }
    
    func createFireStoreUser(user: UserModel) {
        // 1. Create Document reference
        let newUserRef = Firestore.firestore().collection("users").document(user.id)
        
        // 2. Create Model data
        let data = UserModel.modelToData(user: user)
        
        // 3. Upload To firestore
        newUserRef.setData(data) { (error) in
            if let error = error {
                print(error.localizedDescription)
                self.handleFireAuthError(error: error,
                                    fontSize: 24,
                                    textColor: #colorLiteral(red: 0.9254902005, green: 0.3018482075, blue: 0.1536569698, alpha: 1),
                                    bgColor: .white)
                return
            } else {
                self.dismiss(animated: true, completion: nil)
            }
            self.hideActivityIndicator()
        }
    
    }
}



//MARK: -
extension RegisterVC {
    private func setupViews(){
        view.addSubview(myview)
        view.addSubview(stackView)
        view.addSubview(personImgView)
        view.addSubview(checkPaswoordFieldImg)
        view.addSubview(checkRePasswordImg)
        setupShadows()
        checkPaswoordFieldImg.isHidden = true
        checkRePasswordImg.isHidden = true
    }
    
    private func setupShadows(){
        
        myview.layer.cornerRadius = 50
        myview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        myview.layer.shadowOpacity = 145
        myview.layer.shadowRadius = 140
        myview.layer.shadowColor = UIColor.blue.cgColor
        
        
        txtEmail.layer.shadowOpacity = 2
        txtEmail.layer.shadowRadius = 2
        txtEmail.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor


        txtPassword.layer.shadowOpacity = 2
        txtPassword.layer.shadowRadius = 2
        txtPassword.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor
        
        txtRePassword.layer.shadowOpacity = 2
        txtRePassword.layer.shadowRadius = 2
        txtRePassword.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor

        txtUsername.layer.shadowOpacity = 2
        txtUsername.layer.shadowRadius = 2
        txtUsername.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor

        registerBtn.layer.shadowOpacity = 2
        registerBtn.layer.shadowRadius = 2
        registerBtn.layer.shadowColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1).cgColor
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
        
        
        checkPaswoordFieldImg.anchor(top: txtPassword.topAnchor,
                             leading: nil,
                             bottom: nil,
                             trailing: txtPassword.trailingAnchor,
                             padding: .init(top: 5, left: 0, bottom: 0, right: 10),
                             size: .init(width: 40, height: 40))
        
        checkRePasswordImg.anchor(top: txtRePassword.topAnchor,
                             leading: nil,
                             bottom: nil,
                             trailing: txtRePassword.trailingAnchor,
                             padding: .init(top: 5, left: 0, bottom: 0, right: 10),
                             size: .init(width: 40, height: 40))
        
    }
}

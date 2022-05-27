//
//  AddCategoryVC.swift
//  ShoppingAdmin
//
//  Created by ugur-pc on 27.05.2022.
//

import UIKit

class AddCategoryVC: UIViewController {

    
    private let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.text = "Category Name"
        label.textColor = #colorLiteral(red: 0.1709887727, green: 0.1870856636, blue: 0.2076978542, alpha: 1)
        label.textAlignment = .center
        label.numberOfLines = 0
      
        return label
    }()
    
    private let txtCategoryName: CustomTextField = {
        let txt = CustomTextField(padding: 24, height: 55)
        txt.backgroundColor = .white
        txt.placeholder = "Category Name"
        txt.layer.borderWidth = 1
        txt.textColor = .blue
        return txt
    }()
    
    public var categoryimgView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "addphoto")
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        iv.layer.borderWidth = 0.5
        iv.layer.borderColor = UIColor.darkGray.cgColor
        iv.clipsToBounds = true
       
        return iv
    }()
    
    
    private let addBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Add Category", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 15
        btn.backgroundColor = AppColors.DarkGreen
        btn.layer.borderWidth = 1
        btn.layer.borderColor = AppColors.DarkGreen.cgColor
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
       // btn.addTarget(self, action: #selector(clickRegisterBtn), for: .touchUpInside)
        return btn
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [categoryNameLabel,txtCategoryName ])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(stackView)
        view.addSubview(categoryimgView)
        view.addSubview(addBtn)

        setConstraints()
        addTapGestureForImage()
    }
    
    private func addTapGestureForImage(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickImg(_:)))
        tap.numberOfTapsRequired = 1
        categoryimgView.isUserInteractionEnabled = true
        categoryimgView.addGestureRecognizer(tap)
    }
    
    @objc func clickImg( _ tap: UITapGestureRecognizer){
        launchImagePicker()
    }
}

//MARK: -
extension AddCategoryVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func launchImagePicker() {
        let imagePicker  = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        
        categoryimgView.contentMode = .scaleAspectFill
        categoryimgView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}


//MARK: - Constraints
extension AddCategoryVC {
    private func setConstraints(){
        
         stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          leading: view.leadingAnchor,
                          bottom: nil,
                          trailing: view.trailingAnchor,
                          padding: .init(top: 50, left: 10, bottom: 0, right: 10),
                          size: .init(width: 0, height: 78))
         
         categoryimgView.anchor(top:stackView.bottomAnchor ,
                                leading: nil,
                                bottom: nil,
                                trailing: nil,
                                padding: .init(top: 20, left: 0, bottom: 0, right: 0),
                                size: .init(width: 260, height: 235))
         categoryimgView.centerXInSuperview()
         
         addBtn.anchor(top: categoryimgView.bottomAnchor,
                       leading: view.leadingAnchor,
                              bottom: nil,
                       trailing: view.trailingAnchor,
                              padding: .init(top: 50, left: 10, bottom: 0, right: 10),
                              size: .init(width: 0, height: 60))
    }
}

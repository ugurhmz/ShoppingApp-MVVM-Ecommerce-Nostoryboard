//
//  AddProductsVC.swift
//  ShoppingAdmin
//
//  Created by ugur-pc on 29.05.2022.
//

import UIKit

class AddProductsVC: UIViewController {
    
    var homeViewModel = HomeViewModel()
    var allCategories: [CategoryModel]? = []
    var lastIndexActive:IndexPath = [1 ,0]
    var myBool: Bool = false
   
    
    private let prdTitleField: CustomTextField = {
        let txt = CustomTextField(padding: 24, height: 55)
        txt.backgroundColor = .white
        txt.attributedPlaceholder = NSAttributedString(string:"Product title...", attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font :UIFont(name: "Arial", size: 20)!])
        txt.textColor = .black
        txt.layer.borderWidth = 1
        return txt
    }()
    private let prdPriceField: CustomTextField = {
        let txt = CustomTextField(padding: 24, height: 55)
        txt.backgroundColor = .white
        txt.attributedPlaceholder = NSAttributedString(string:"Product price...", attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font :UIFont(name: "Arial", size: 20)!])
        txt.textColor = .black
        txt.layer.borderWidth = 1
        return txt
    }()
    
    private let prdStockField: CustomTextField = {
        let txt = CustomTextField(padding: 24, height: 55)
        txt.backgroundColor = .white
        txt.attributedPlaceholder = NSAttributedString(string:"Product stock...", attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font :UIFont(name: "Arial", size: 20)!])
        txt.textColor = .black
        txt.layer.borderWidth = 1
        return txt
    }()
    
    
    private let selectCategory: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        cv.backgroundColor = .white
        cv.register(SelectCategoryCell.self,
                    forCellWithReuseIdentifier: SelectCategoryCell.identifier)
        return cv
    }()
  
    
    private let prdDescriptionText: UITextView = {
           let tv = UITextView()
           tv.font = .systemFont(ofSize: 20)
           tv.textAlignment = .left
           tv.backgroundColor = .white
           tv.layer.cornerRadius = 12
           tv.isEditable = true
           tv.textColor = .black
           return tv
       }()
 
    private let prdImgView: UIImageView = {
         let iv = UIImageView()
         iv.image = UIImage(named: "addphoto")
         iv.contentMode = .scaleAspectFill
         iv.clipsToBounds = true
         iv.layer.cornerRadius = 15
         return iv
    }()
    
    private let addBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Add Product", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 15
        btn.backgroundColor = AppColors.DarkGreen
        btn.layer.borderWidth = 1
        btn.layer.borderColor = AppColors.DarkGreen.cgColor
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
       // btn.addTarget(self, action: #selector(clickAddCategory), for: .touchUpInside)
        return btn
    }()
    
   
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [prdTitleField, prdPriceField, prdStockField,selectCategory, prdDescriptionText, prdImgView, addBtn])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupViews()
        setConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        homeViewModel.fetchAllCategoriesData()
        
        self.homeViewModel.reloadData = { [weak self] in
            guard let self = self else {return }
            self.allCategories = self.homeViewModel.categoryList
            self.selectCategory.reloadData()
           
        }
    }
}


//MARK: - Delegate, DataSource
extension AddProductsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allCategories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCategoryCell.identifier, for: indexPath) as! SelectCategoryCell
        
        cell.data(data: self.allCategories?[indexPath.row] ?? CategoryModel(data: [:]))
        cell.layer.cornerRadius = 20
        cell.backgroundColor = .lightGray.withAlphaComponent(0.8)
        
        
        return cell
    }
 


       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

           if self.lastIndexActive != indexPath {

           
           let cell = collectionView.cellForItem(at: indexPath) as! SelectCategoryCell
           cell.configure(select: true)
               print(self.allCategories?[indexPath.item].name)

           let cell1 = collectionView.cellForItem(at: self.lastIndexActive) as? SelectCategoryCell
               cell1?.configure(select: false)
           self.lastIndexActive = indexPath
              
           }
       }
}

//MARK: -
extension AddProductsVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            return CGSize(width: (view.frame.width / 3) - 16 ,
                          height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
    }
    
   
    
}


//MARK: -
extension AddProductsVC {
    
    private func setupViews(){
        view.addSubview(stackView)
        stackView.setCustomSpacing(15, after: prdDescriptionText)
        stackView.setCustomSpacing(25, after: prdImgView)
        
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        selectCategory.delegate = self
        selectCategory.dataSource = self
    }
    
    private func setConstraints(){
        
        prdTitleField.anchor(top: nil,
                             leading: nil,
                             bottom: nil,
                             trailing: nil,
                             size: .init(width: 0, height: 55))
        
        prdPriceField.anchor(top: nil,
                             leading: nil,
                             bottom: nil,
                             trailing: nil,
                             size: .init(width: 0, height: 55))
        
        prdStockField.anchor(top: nil,
                             leading: nil,
                             bottom: nil,
                             trailing: nil,
                             size: .init(width: 0, height: 55))
        
        selectCategory.anchor(top: nil,
                              leading: nil,
                              bottom: nil,
                              trailing: nil,
                              size: .init(width: 0, height:105))
        
        prdDescriptionText.anchor(top: nil,
                             leading: nil,
                             bottom: nil,
                             trailing: nil,
                             size: .init(width: 0, height: 200))
        
        stackView.anchor(top: view.topAnchor,
                         leading: view.leadingAnchor,
                         bottom: view.bottomAnchor,
                         trailing: view.trailingAnchor,
                         padding: .init(top: 8, left: 0, bottom: 25, right: 0) )
       
        
        prdImgView.anchor(top: nil,
                          leading: nil,
                          bottom: nil,
                          trailing: nil,
                          size: .init(width: 100, height: 160))
        
        addBtn.anchor(top: nil,
                      leading: nil,
                      bottom: nil,
                      trailing: nil,
                      size: .init(width: 0, height: 50))
    }
}

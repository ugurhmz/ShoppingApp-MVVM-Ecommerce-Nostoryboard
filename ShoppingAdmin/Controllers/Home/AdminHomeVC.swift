//
//  ViewController.swift
//  ShoppingAdmin
//
//  Created by ugur-pc on 20.05.2022.
//

import UIKit

class AdminHomeVC: UIViewController {
    
    lazy var  homeViewModel = HomeViewModel()
    var editClosure:((CategoryModel) -> Void)?
    
    var headerView = ByCategoryHeaderView()
    
     private let mainCollectionView: UICollectionView = {
         let layout = UICollectionViewFlowLayout()
         let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
         layout.scrollDirection = .vertical
         cv.backgroundColor = .white
         cv.contentInset = UIEdgeInsets(top: 50, left: 10, bottom: 0, right:10)
        
         cv.register(AdminHomeCell.self,
                                   forCellWithReuseIdentifier: AdminHomeCell.identifier)
         cv.register(ByCategoryHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ByCategoryHeaderView.identifier)
         return cv
     }()
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        homeViewModel.fetchAllCategoriesData()
        
        // reload data with closure
        self.homeViewModel.reloadData = { [weak self] in
            guard let self = self else { return }
            self.mainCollectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        settingsNavigateBar()
        setConstraints()
    }
    
}

//MARK: -
extension AdminHomeVC {
    private func setupViews(){
        view.addSubview(mainCollectionView)
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        view.backgroundColor = .white
    }
    
    private func setConstraints(){
        
        mainCollectionView.anchor(top: view.topAnchor,
                                  leading: view.leadingAnchor,
                                  bottom: view.bottomAnchor,
                                  trailing: view.trailingAnchor)
    }
    
    private func settingsNavigateBar() {
        if #available(iOS 13.0, *) {
          let navBarAppearance = UINavigationBarAppearance()
           navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont(name: "Charter-Black", size: 26)!]
         
            navigationController?.navigationBar.barStyle = .black
          navigationController?.navigationBar.standardAppearance = navBarAppearance
          navigationController?.navigationBar.compactAppearance = navBarAppearance
          navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            
          navigationController?.navigationBar.prefersLargeTitles = false
          navigationItem.title = "Admin"
          
          }
        
        let addCategoryBtn = UIButton(type: .system)
        addCategoryBtn.setImage(UIImage(systemName: "link.badge.plus"), for: .normal)
        addCategoryBtn.setTitle("Add Category", for: .normal)
       
        
        let loginBtn = UIButton(type: .system)
        loginBtn.setImage(UIImage(systemName: "arrow.up.and.person.rectangle.portrait"), for: .normal)
        loginBtn.setTitle("Login", for: .normal)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addCategoryBtn)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: loginBtn)
        navigationController?.navigationBar.tintColor = .label
        addCategoryBtn.addTarget(self, action: #selector(clickAddCategory), for: .touchUpInside)
        loginBtn.addTarget(self, action: #selector(clickLoginBtn), for: .touchUpInside)
    }
    @objc func clickAddCategory(){
        let vc = AddEditCategoryVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func clickLoginBtn(){
        print("abc")
    }
}

//MARK: - Delegate, DataSource
extension AdminHomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

     func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.homeViewModel.categoryList?.count ?? 0
    }
    
     func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdminHomeCell.identifier, for: indexPath) as! AdminHomeCell
        
         
          if let categoryValue = self.homeViewModel.categoryList {
              cell.fillCategoryData(category: categoryValue[indexPath.item])
          }
         
         
        cell.layer.cornerRadius = 8
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let categoryValue = self.homeViewModel.categoryList {
            let vc = AdminProductsByCategoryVC()
            let selectedCategory = categoryValue[indexPath.item]
            vc.selCategory = selectedCategory   // AddEditCategoryVC pass data -> selected category
            let lowerCaseStr: String = selectedCategory.name.lowercased()
            
            print("seçilen kategori ID",selectedCategory.id)
            vc.selectStr = lowerCaseStr
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ByCategoryHeaderView.identifier, for: indexPath) as! ByCategoryHeaderView
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width,
                      height: 200)
    }
    
    
    
    
}


//MARK: -  UICollectionViewFlowLayoutDelegate
extension AdminHomeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        return CGSize(width: (view.frame.width / 3) - 20,
                          height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 50, left: 4, bottom: 10, right: 4)
    }
 
}

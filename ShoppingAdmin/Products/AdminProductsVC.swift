//
//  AdminProductsVC.swift
//  ShoppingAdmin
//
//  Created by ugur-pc on 28.05.2022.
//

import UIKit

class AdminProductsVC: UIViewController {

     // General CollectionView
      private let generalCollectionView: UICollectionView = {
          let layout = UICollectionViewFlowLayout()
          layout.scrollDirection = .vertical
          let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
          cv.showsHorizontalScrollIndicator = false
          cv.backgroundColor = .white
         
          //register cells
          cv.register(AdminProductsCell.self,
                      forCellWithReuseIdentifier: AdminProductsCell.identifier)
          return cv
      }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        generalCollectionView.delegate = self
        generalCollectionView.dataSource = self
        settingsNavigateBar()
    }
    
    private func setupViews(){
        view.addSubview(generalCollectionView)
    }
}

//MARK: -  Navbar Settings
extension AdminProductsVC {
    
    private func settingsNavigateBar() {
        if #available(iOS 13.0, *) {
          let navBarAppearance = UINavigationBarAppearance()
           navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont(name: "Charter-Black", size: 24)!]
         
            navigationController?.navigationBar.barStyle = .black
          navigationController?.navigationBar.standardAppearance = navBarAppearance
          navigationController?.navigationBar.compactAppearance = navBarAppearance
          navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
          navigationController?.navigationBar.prefersLargeTitles = false
          }
        
        let addProducsBtn = UIButton(type: .system)
        addProducsBtn.setImage(UIImage(systemName: "rectangle.stack.badge.plus"), for: .normal)
        addProducsBtn.setTitle("Add Product", for: .normal)
        addProducsBtn.tintColor = #colorLiteral(red: 0, green: 0.6297852238, blue: 0.05335827891, alpha: 1)
        addProducsBtn.titleLabel?.font = UIFont(name: "Charter-Black", size: 21)
        
        let editCategoryBtn = UIButton(type: .system)
        editCategoryBtn.setImage(UIImage(systemName: "pencil"), for: .normal)
        editCategoryBtn.setTitle("Edit Category", for: .normal)
        editCategoryBtn.tintColor = #colorLiteral(red: 0.8279277146, green: 0.3757062302, blue: 0.0934060527, alpha: 1)
        editCategoryBtn.titleLabel?.font = UIFont(name: "Charter-Black", size: 21)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: addProducsBtn),
            UIBarButtonItem(customView: editCategoryBtn)
        ]
        navigationController?.navigationBar.tintColor = .label
        addProducsBtn.addTarget(self, action: #selector(clickAddProducts), for: .touchUpInside)
        editCategoryBtn.addTarget(self, action: #selector(clickEditCategoryBtn), for: .touchUpInside)
    }
    @objc func clickAddProducts(){
        let vc = AddCategoryVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func clickEditCategoryBtn(){
        print("abc")
    }
}

//MARK: - Delegate & DataSource
extension AdminProductsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = generalCollectionView.dequeueReusableCell(withReuseIdentifier: AdminProductsCell.identifier, for: indexPath) as! AdminProductsCell
        cell.layer.cornerRadius = 12
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 30
    }
}

//MARK: - DelegateFlowLayout
extension AdminProductsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CGSize(width: generalCollectionView.frame.width - 35,
                      height: generalCollectionView.frame.width - 245)
    }
    // First element padding
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
    }
   
}

//MARK: -
extension AdminProductsVC {
    private func setConstraints(){
        generalCollectionView.fillSuperview()
    }
}


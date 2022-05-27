//
//  ViewController.swift
//  ShoppingAdmin
//
//  Created by ugur-pc on 20.05.2022.
//

import UIKit

class AdminHomeVC: UIViewController {
    
    
     private let mainCollectionView: UICollectionView = {
         let layout = UICollectionViewFlowLayout()
         let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
         layout.scrollDirection = .vertical
         cv.backgroundColor = .white
        
         cv.register(AdminHomeCell.self,
                                   forCellWithReuseIdentifier: AdminHomeCell.identifier)
         return cv
     }()
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
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
    }
    
    private func setConstraints(){
        mainCollectionView.fillSuperview()
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
        let vc = AddCategoryVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func clickLoginBtn(){
        print("abc")
    }
}

//MARK: -
extension AdminHomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

     func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
     func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdminHomeCell.identifier, for: indexPath) as! AdminHomeCell
        
        cell.backgroundColor = UIColor(hue: drand48(),
                                       saturation: 1,
                                       brightness: 1,
                                       alpha: 1)
        
        cell.layer.cornerRadius = 8
        return cell
    }
}


//MARK: -  UICollectionViewFlowLayoutDelegate
extension AdminHomeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        return CGSize(width: (view.frame.width / 3) - 16 ,
                          height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
    }
    
}

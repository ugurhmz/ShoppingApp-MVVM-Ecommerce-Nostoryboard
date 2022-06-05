//
//  ProfileVC.swift
//  FurnitureShop
//
//  Created by ugur-pc on 19.05.2022.
//

import UIKit
import Firebase
class ProfileVC: UIViewController {
    
    var homeViewModel = HomeViewModel()
    var currentUsr: User?
    var countFavItems = 0
    var countCartItem = 0

    private let mainCollectionView: UICollectionView = {
          let layout = UICollectionViewFlowLayout()
          let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
          layout.scrollDirection = .vertical
          cv.register(ProfileTopCell.self,
                      forCellWithReuseIdentifier: ProfileTopCell.identifier)
          
          cv.register(ProfileBottomCell.self,
                      forCellWithReuseIdentifier: ProfileBottomCell.identifier)
          return cv
          
      }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
       
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        
        
        // reload data with closure
        self.homeViewModel.reloadData = { [weak self] in
            guard let self = self else { return }
            self.mainCollectionView.reloadData()
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // When login
        if let user = Auth.auth().currentUser, !user.isAnonymous {
            self.homeViewModel.fetchFavItemsCurrentUser(userId: user.uid)
            self.homeViewModel.fetchCartItemsCurrentUser(userId: user.uid)
          
            self.currentUsr = user
            self.countCartItem = self.homeViewModel.sumUsertCartItem
            if userService.userListener == nil {
                userService.getCurrentUser()
            }
            
        }
        
        self.homeViewModel.favItemCount = { [weak self] in
            guard let self = self else { return }
            if let favItem = self.homeViewModel.favouritesArrList {
                self.countFavItems = favItem.count
            }
        }
        
        self.homeViewModel.cartItemCount = {  [weak self] in
            guard let self = self else { return }
            self.countCartItem =   self.homeViewModel.sumUsertCartItem
        }
       
        
    }
    
}
extension ProfileVC {
    private func setupViews(){
        view.addSubview(mainCollectionView)
    }
    
    private func setConstraints(){
        mainCollectionView.anchor(top: view.topAnchor,
                                  leading: view.leadingAnchor,
                                  bottom: view.bottomAnchor,
                                  trailing: view.trailingAnchor)
       
    }
}

//MARK: - Delegate, DataSource
extension ProfileVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let topCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileTopCell.identifier, for: indexPath) as! ProfileTopCell
            
            topCell.layer.shadowColor = #colorLiteral(red: 0.4392156863, green: 0.01176470588, blue: 0.5058823529, alpha: 1).cgColor
            topCell.layer.shadowOffset = CGSize(width: 2, height: 2)
            topCell.layer.shadowOpacity = 2.8
            topCell.layer.shadowRadius = 10
          
            if let currentUser = self.currentUsr {
                topCell.configure(user: currentUser)
            }
            return topCell
        }
        
        
        let bottomCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileBottomCell.identifier, for: indexPath) as! ProfileBottomCell
        bottomCell.fillData(count:  self.countFavItems, cartCount: self.countCartItem)
        return bottomCell
    }
    
    
}

//MARK: - ViewDelegateFlowLayout
extension ProfileVC: UICollectionViewDelegateFlowLayout {
    // sizeForItemAt, cell -> w,h
      func collectionView(_ collectionView: UICollectionView,
                          layout collectionViewLayout: UICollectionViewLayout,
                          sizeForItemAt indexPath: IndexPath) -> CGSize {
          // topCell
          if indexPath.section == 0 {
              return CGSize(width: mainCollectionView.frame.width,
                            height: 350)
          }
          
          // bottomListcell
          return CGSize(width: mainCollectionView.frame.width,
                        height: 450)
      }
          
    
      func collectionView(_ collectionView: UICollectionView,
                          layout collectionViewLayout: UICollectionViewLayout,
                          insetForSectionAt section: Int) -> UIEdgeInsets {
          if section == 0 {
              return  .zero
          }
          
          return UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
      }
}


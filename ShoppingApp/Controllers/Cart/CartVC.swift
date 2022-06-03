//
//  CartVC.swift
//  ShoppingApp
//
//  Created by ugur-pc on 26.05.2022.
//
import UIKit
import Firebase

class CartVC: UIViewController {
    var homeViewModel = HomeViewModel()
    var cartItemArr: [CartModel] = []
    
    // General CollectionView
      private let generalCollectionView: UICollectionView = {
          let layout = UICollectionViewFlowLayout()
          layout.scrollDirection = .vertical
          let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
          cv.showsHorizontalScrollIndicator = false
          cv.backgroundColor = .white
          //register cells
          cv.register(CartCollectionCell.self,
                      forCellWithReuseIdentifier: CartCollectionCell.identifier)
          return cv
      }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        generalCollectionView.delegate = self
        generalCollectionView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // When login
        if let user = Auth.auth().currentUser, !user.isAnonymous {
            self.homeViewModel.fetchCartItemsCurrentUser(userId: user.uid)
            //self.currentUser = user.email
            if userService.userListener == nil { userService.getCurrentUser() }
        }
    }
    
    private func setupViews(){
        view.addSubview(generalCollectionView)
        self.homeViewModel.cartData = { [weak self] in
            guard let self = self else { return }
            if let cartItem = self.homeViewModel.fetchCartArrList {
                self.cartItemArr = cartItem
            }
            self.generalCollectionView.reloadData()
        }
    }
}
extension CartVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // numberOfItemsInSection ( how many cells )
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return self.cartItemArr.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = generalCollectionView.dequeueReusableCell(withReuseIdentifier: CartCollectionCell.identifier, for: indexPath) as! CartCollectionCell
        cell.layer.cornerRadius = 12
        cell.fillData(cartItems: self.cartItemArr[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 25
    }
}

//MARK: - DelegateFlowLayout
extension CartVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CGSize(width: generalCollectionView.frame.width - 35,height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
    }
}
//MARK: -
extension CartVC {
    private func setConstraints(){
        generalCollectionView.fillSuperview()
    }
}



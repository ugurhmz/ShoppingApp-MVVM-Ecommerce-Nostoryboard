//
//  CartVC.swift
//  ShoppingApp
//
//  Created by ugur-pc on 26.05.2022.
//
import UIKit
import Firebase
import ProgressHUD

class CartVC: UIViewController {
    var homeViewModel = HomeViewModel()
    var cartItemArr: [CartModel] = []
    var sumQuantity = 0.0
    var checkoutHiddenClosure: VoidClosure?
    private let checkOutView = CartView()
    var currentUserId: String?
    
    // General CollectionView
    private let generalCollectionView: UICollectionView = {
          let layout = UICollectionViewFlowLayout()
          layout.scrollDirection = .vertical
          let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
          cv.showsHorizontalScrollIndicator = false
          cv.backgroundColor = .white
          cv.register(CartCollectionCell.self,
                          forCellWithReuseIdentifier: CartCollectionCell.identifier)
          cv.register(CheckOutReusableView.self,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CheckOutReusableView.Identifier)
          return cv
      }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        checkOutView.backgroundColor = #colorLiteral(red: 0.8906015158, green: 0.2020004392, blue: 0.3312987983, alpha: 1)
        generalCollectionView.delegate = self
        generalCollectionView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // When login
        if let user = Auth.auth().currentUser, !user.isAnonymous {
            self.homeViewModel.fetchCartItemsCurrentUser(userId: user.uid)
            //self.currentUser = user.email
            
            
            self.currentUserId = user.uid
            
            if userService.userListener == nil { userService.getCurrentUser() }
            
            self.homeViewModel.cartData = { [weak self] in
                guard let self = self else { return }
                
                if let cartItem = self.homeViewModel.fetchCartArrList {
                    self.cartItemArr = cartItem
                    self.sumQuantity = cartItem.reduce(0) { $0 + $1.price * Double($1.quantity)}
                    self.checkOutView.fillData(sumData: self.sumQuantity)
                }
                
                if   self.cartItemArr.count < 4 {
                    self.checkOutView.isHidden = true
                }
                
                self.generalCollectionView.reloadData()
            }
        }
    }
    
    private func setupViews(){
        view.addSubview(generalCollectionView)
        view.addSubview(checkOutView)
        checkOutView.layer.cornerRadius = 40
        settingsNavigateBar()
        
    }
    
    private func settingsNavigateBar(){
               if #available(iOS 13.0, *) {
                 let navBarAppearance = UINavigationBarAppearance()
                  navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont(name: "Charter-Black", size: 26)!]
                
                   navigationController?.navigationBar.barStyle = .black
                 navigationController?.navigationBar.standardAppearance = navBarAppearance
                 navigationController?.navigationBar.compactAppearance = navBarAppearance
                 navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
                 navigationController?.navigationBar.prefersLargeTitles = false
                 }
               
               let deleteAllBtn = UIButton(type: .system)
                   deleteAllBtn.setImage(UIImage(systemName: "trash.circle.fill"), for: .normal)
                   deleteAllBtn.setTitle("Delete All", for: .normal)
                   deleteAllBtn.tintColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                   deleteAllBtn.titleLabel?.font = UIFont(name: "Charter-Black", size: 18)
               
               navigationItem.rightBarButtonItems = [
                   UIBarButtonItem(customView: deleteAllBtn)
               ]
               navigationController?.navigationBar.tintColor = .label
        
        deleteAllBtn.addTarget(self, action: #selector(clickDeleteAllCartItems), for: .touchUpInside)
           
    }
    
    @objc func clickDeleteAllCartItems(){
        
        if let userId = self.currentUserId {
            self.homeViewModel.deleteAllCartItems(userId: userId)
        }
    }
    
}
extension CartVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
        self.checkOutView.isHidden = false
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        
        if distanceFromBottom < height {
            self.checkOutView.isHidden = true
        }
    }
    
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
        cell.fillData(cartItems: self.cartItemArr[indexPath.item])
            cell.addToCartClosure = { [weak self]  in
                if let allCartArr = self?.homeViewModel.fetchCartArrList{
                    userService.addToCartTwo(count: allCartArr[indexPath.item].quantity + 1, product: allCartArr[indexPath.item])
                }
            }
        
        cell.subtractToCartClosure = { [weak self]  in
            if let allCartArr = self?.homeViewModel.fetchCartArrList{
                userService.addToCartTwo(count: allCartArr[indexPath.item].quantity - 1, product: allCartArr[indexPath.item])
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionFooter {
            let footerCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier:CheckOutReusableView.Identifier , for: indexPath) as! CheckOutReusableView
           
      
            footerCell.fillData(sumData: self.sumQuantity)
            return footerCell
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return  CGSize(width: generalCollectionView.frame.width,
                       height: 105)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let clickedItem = self.homeViewModel.fetchCartArrList?[indexPath.item].prdId {
            self.homeViewModel.fetchProductWithId(filterById: clickedItem)
        }
        
        self.homeViewModel.clickDataClosure = { [weak self] in
            if let clickedItem = self?.homeViewModel.clickedCartItemArr.last {
                let vc = ProductDetailVC()
                vc.configure(with: clickedItem )
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
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
        checkOutView.anchor(top: nil,
                            leading: view.leadingAnchor,
                            bottom: view.safeAreaLayoutGuide.bottomAnchor,
                            trailing: view.trailingAnchor,
                            padding: .init(top: 0, left: 20, bottom: 0, right: 20),
                            size: .init(width: 0, height: 80)
        )
    }
}



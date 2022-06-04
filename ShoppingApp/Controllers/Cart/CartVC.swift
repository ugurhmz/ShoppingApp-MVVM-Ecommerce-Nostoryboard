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
    var sumQuantity = 0.0
    private let checkOutView = CartView()

    
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
            if userService.userListener == nil { userService.getCurrentUser() }
            
            self.homeViewModel.cartData = { [weak self] in
                guard let self = self else { return }
                
                if let cartItem = self.homeViewModel.fetchCartArrList {
                    self.cartItemArr = cartItem
                    self.sumQuantity = cartItem.reduce(0) { $0 + $1.price * Double($1.quantity)}
                    self.checkOutView.fillData(sumData: self.sumQuantity)
//                    cartItem.forEach({
//                        print("\($0.name), MİKTAR -> | \($0.quantity) -> \($0.price)")
//                        totalPrice += Double($0.quantity) * $0.price
//                        print("TOTAL PRİCE", totalPrice)
//                    })
                }
                
                if self.cartItemArr.count < 4 {
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



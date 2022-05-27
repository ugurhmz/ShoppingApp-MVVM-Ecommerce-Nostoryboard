//
//  CartVC.swift
//  ShoppingApp
//
//  Created by ugur-pc on 26.05.2022.
//

import UIKit

class CartVC: UIViewController {
    
    // General CollectionView
      private let generalCollectionView: UICollectionView = {
          let layout = UICollectionViewFlowLayout()
          layout.scrollDirection = .vertical
          let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
          cv.showsHorizontalScrollIndicator = false
          cv.backgroundColor = .systemBackground
         
          
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
    
    private func setupViews(){
        view.addSubview(generalCollectionView)
    }
    
}
extension CartVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    // numberOfItemsInSection ( how many cells )
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = generalCollectionView.dequeueReusableCell(withReuseIdentifier: CartCollectionCell.identifier, for: indexPath) as! CartCollectionCell
           
        cell.backgroundColor = .orange
        cell.layer.cornerRadius = 15
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       
            return 15
        
    }
    
    
}

//MARK: - DelegateFlowLayout
extension CartVC: UICollectionViewDelegateFlowLayout {
    
    
    // sizeForItemAt, cell -> w,h
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CGSize(width: generalCollectionView.frame.width - 35,
                      height: generalCollectionView.frame.width - 300)
        
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



//
//  ProductDetailVC.swift
//  ShoppingApp
//
//  Created by ugur-pc on 26.05.2022.
//

import UIKit


class ProductDetailVC: UIViewController {

    var didSelectClosure: ( (ProductModel) -> Void)?

    var myObj: ProductModel?
    private  var generalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.register(ProductDetailCell.self,
                    forCellWithReuseIdentifier: ProductDetailCell.identifier)
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(generalCollectionView)
        generalCollectionView.fillSuperview()
        generalCollectionView.delegate = self
        generalCollectionView.dataSource = self
        generalCollectionView.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .blue
    }
}

//MARK: - Pass Data
extension ProductDetailVC {
    func configure(with productValue: ProductModel){
        self.myObj = productValue
    }
}

//MARK: -
extension ProductDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductDetailCell.identifier, for: indexPath) as! ProductDetailCell
        
        if let prdValue = self.myObj {
            cell.configure(objModel: prdValue)
        }
        return cell
    }
}

extension ProductDetailVC: UICollectionViewDelegateFlowLayout {
    
    // sizeForItemAt, cell -> w,h
       func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           sizeForItemAt indexPath: IndexPath) -> CGSize {

           return CGSize(width: generalCollectionView.frame.width,
                         height: generalCollectionView.frame.height)
           
       }
    
    func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           insetForSectionAt section: Int) -> UIEdgeInsets {
         
           return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
       }
}


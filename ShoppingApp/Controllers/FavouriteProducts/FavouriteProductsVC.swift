//
//  FavouriteProductsVC.swift
//  ShoppingApp
//
//  Created by ugur-pc on 1.06.2022.
//

import UIKit
import FirebaseAuth

class FavouriteProductsVC: UIViewController {

    var homeViewModel = HomeViewModel()
    var arrFavList: [ProductModel]? = []
    
    // General CollectionView
     private let generalCollectionView: UICollectionView = {
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .vertical
         let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
         cv.showsHorizontalScrollIndicator = false
         cv.backgroundColor = .white
        
         //register cells
         cv.register(ProductsByCategoryCell.self,
                     forCellWithReuseIdentifier: ProductsByCategoryCell.identifier)
         return cv
     }()
    
    private let dontHavePrdLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.text = "You don't have any favourite products"
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showActivityIndicator()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let user = Auth.auth().currentUser, !user.isAnonymous {
            self.homeViewModel.fetchFavItemsCurrentUser(userId: user.uid)
        }
        
        self.homeViewModel.reloadData = { [weak self] in
            guard let self = self else { return }
            self.arrFavList = self.homeViewModel.favouritesArrList
            if let count = self.arrFavList?.count {
                if count == 0 {
                    self.dontHavePrdLbl.isHidden = false
                } else if count > 0 {
                    self.dontHavePrdLbl.isHidden = true
                }
            }
            self.generalCollectionView.reloadData()
        }
        self.hideActivityIndicator()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        setupViews()
        setConstraints()
        self.dontHavePrdLbl.isHidden = true
    }
    
    private func setupViews() {
        view.addSubview(generalCollectionView)
        view.addSubview(dontHavePrdLbl)
        dontHavePrdLbl.fillSuperview()
        generalCollectionView.delegate = self
        generalCollectionView.dataSource = self
    }
}

//MARK: - Constraints
extension FavouriteProductsVC {
    private func setConstraints(){
        generalCollectionView.fillSuperview()
    }
}

//MARK: -  DELEGATE & DATASOURCE
extension FavouriteProductsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.arrFavList?.count ?? 0
    }

    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = generalCollectionView.dequeueReusableCell(withReuseIdentifier: ProductsByCategoryCell.identifier, for: indexPath) as! ProductsByCategoryCell
        cell.layer.cornerRadius = 12
        if let favouriteValuesArr = self.arrFavList {
            cell.fillData(data: favouriteValuesArr[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProductDetailVC()
        if let clickedPrdItem = self.arrFavList?[indexPath.row] {
            vc.configure(with: clickedPrdItem)
            showActivityIndicator()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK: - DelegateFlowLayout
extension FavouriteProductsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CGSize(width: generalCollectionView.frame.width - 35,
                      height: generalCollectionView.frame.width - 200)
    }
    // First element padding
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
    }
   
}

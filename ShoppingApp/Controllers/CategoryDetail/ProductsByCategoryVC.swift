//
//  CategoryVC.swift
//  ShoppingApp
//
//  Created by ugur-pc on 21.05.2022.
//

import UIKit

class ProductsByCategoryVC: UIViewController {

    var selectCategoryId: String?
    var arrProductsByCategory: [ProductModel]? = []
    var homeViewModel = HomeViewModel()
    
    // General CollectionView
     private let generalCollectionView: UICollectionView = {
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .vertical
         let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
         cv.showsHorizontalScrollIndicator = false
         cv.backgroundColor = .white
        
         //register cells
         cv.register(AdminProductsByCategoryCell.self,
                     forCellWithReuseIdentifier: AdminProductsByCategoryCell.identifier)
         return cv
     }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showActivityIndicator()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let myStr = self.selectCategoryId {
            self.homeViewModel.fetchCategoryToProductsWithId(filterById: myStr)
            self.hideActivityIndicator()
        }
        
        // reload data with closure
        self.homeViewModel.reloadData = { [weak self] in
            guard let self = self else { return }
            self.arrProductsByCategory = self.homeViewModel.adminArrList
            self.generalCollectionView.reloadData()
        }
        self.hideActivityIndicator()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        setNavigationBar()
        generalCollectionView.delegate = self
        generalCollectionView.dataSource = self
        
    }
    
    private func setupViews(){
        view.addSubview(generalCollectionView)
    }
    
    private func setNavigationBar(){
        navigationController?.navigationBar.tintColor = .blue
    }
}


//MARK: -  DELEGATE & DATASOURCE
extension ProductsByCategoryVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.arrProductsByCategory?.count ?? 0
    }

    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = generalCollectionView.dequeueReusableCell(withReuseIdentifier: AdminProductsByCategoryCell.identifier, for: indexPath) as! AdminProductsByCategoryCell
        cell.layer.cornerRadius = 12
        
        
        cell.fillData(data: self.arrProductsByCategory?[indexPath.row] ?? ProductModel(data: [:]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 30
    }
}

//MARK: - DelegateFlowLayout
extension ProductsByCategoryVC: UICollectionViewDelegateFlowLayout {
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

//MARK: - CONSTRAINTS
extension ProductsByCategoryVC {
    private func setConstraints(){
        generalCollectionView.fillSuperview()
    }
}

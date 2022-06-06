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
    var searchMode = false
    var filteredArrayTodisplay = [ProductModel]()
    
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
        
        configureSearchBarButton()
    }
 
    private func setupViews(){
        view.addSubview(generalCollectionView)
        
    }
    
    private func setNavigationBar(){
        navigationController?.navigationBar.tintColor = .blue
    }
}


//MARK: - SEARCHBAR CONFIGURES
extension ProductsByCategoryVC {
    
    func configureSearchBarButton(){
                navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                                    target: self,
                                                                    action: #selector(showSearchBar))
                navigationItem.rightBarButtonItem?.tintColor = .red
    }
    
    @objc func showSearchBar(){
               searchingFunc(shouldShow: true)
    }
    
    @objc func searchingFunc(shouldShow: Bool) {
        if shouldShow {
            // searchBar
            let searchBar = UISearchBar()
            searchBar.delegate = self
            searchBar.sizeToFit()
            searchBar.showsCancelButton = true
            searchBar.becomeFirstResponder() // icona tıklayınca searchbar focus
            searchBar.tintColor = .black
            searchBar.searchTextField.backgroundColor = .white
            searchBar.searchTextField.textColor = .black
            navigationItem.rightBarButtonItem = nil
            navigationItem.titleView = searchBar
            
        } else {
            navigationItem.titleView = nil
            configureSearchBarButton()
            searchMode = false
            generalCollectionView.reloadData()
        }
    }
}



//MARK: -  SEARCHBAR DELEGATE
extension ProductsByCategoryVC: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchingFunc(shouldShow: false)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty || searchBar.text == nil {
            searchMode = false
            generalCollectionView.reloadData()
            view.endEditing(true)
        } else {    // search mode ON
            searchMode = true
            if let  myarr = self.arrProductsByCategory {
                    filteredArrayTodisplay = myarr.filter({
                    $0.name.lowercased().contains(searchText.lowercased()) as! Bool
                })
            }
            generalCollectionView.reloadData()
        }
    }
}

//MARK: -  DELEGATE & DATASOURCE
extension ProductsByCategoryVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return searchMode ?                 filteredArrayTodisplay.count : self.arrProductsByCategory?.count ?? 0
    }

    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = generalCollectionView.dequeueReusableCell(withReuseIdentifier: ProductsByCategoryCell.identifier, for: indexPath) as! ProductsByCategoryCell
        cell.layer.cornerRadius = 12
        
        if let productsByCategoryItem = self.arrProductsByCategory?[indexPath.row] {
        searchMode ? cell.fillData(data:filteredArrayTodisplay[indexPath.item]) :  cell.fillData(data: productsByCategoryItem)
        }
        
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

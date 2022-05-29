//
//  AdminProductsVC.swift
//  ShoppingAdmin
//
//  Created by ugur-pc on 28.05.2022.
//

import UIKit

class AdminProductsByCategoryVC: UIViewController {

     lazy var homeViewModel = HomeViewModel()
    var arrProductsByCategory: [ProductModel]? = []
    var selectStr: String?
    var selCategory: CategoryModel?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        generalCollectionView.delegate = self
        generalCollectionView.dataSource = self
        settingsNavigateBar()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showActivityIndicator()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let myStr = self.selectStr {
            self.homeViewModel.fetchCategoryToProducts(getCategoryFilter: myStr)
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
    
    private func setupViews(){
        view.addSubview(generalCollectionView)
    }
}


//MARK: -  NAVBAR SETTINGS
extension AdminProductsByCategoryVC {
    
    private func settingsNavigateBar() {
        if #available(iOS 13.0, *) {
          let navBarAppearance = UINavigationBarAppearance()
           navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont(name: "Charter-Black", size: 24)!]
         
            navigationController?.navigationBar.barStyle = .black
          navigationController?.navigationBar.standardAppearance = navBarAppearance
          navigationController?.navigationBar.compactAppearance = navBarAppearance
          navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
          navigationController?.navigationBar.prefersLargeTitles = false
          }
        
        let addProducsBtn = UIButton(type: .system)
        addProducsBtn.setImage(UIImage(systemName: "rectangle.stack.badge.plus"), for: .normal)
        addProducsBtn.setTitle("Add Product", for: .normal)
        addProducsBtn.tintColor = #colorLiteral(red: 0, green: 0.6297852238, blue: 0.05335827891, alpha: 1)
        addProducsBtn.titleLabel?.font = UIFont(name: "Charter-Black", size: 18)
        
        let editCategoryBtn = UIButton(type: .system)
        editCategoryBtn.setImage(UIImage(systemName: "pencil"), for: .normal)
        editCategoryBtn.setTitle("Edit Category", for: .normal)
        editCategoryBtn.tintColor = #colorLiteral(red: 0.8279277146, green: 0.3757062302, blue: 0.0934060527, alpha: 1)
        editCategoryBtn.titleLabel?.font = UIFont(name: "Charter-Black", size: 18)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: addProducsBtn),
            UIBarButtonItem(customView: editCategoryBtn)
        ]
        navigationController?.navigationBar.tintColor = .label
        addProducsBtn.addTarget(self, action: #selector(clickAddProducts), for: .touchUpInside)
        editCategoryBtn.addTarget(self, action: #selector(clickEditCategoryBtn), for: .touchUpInside)
    }
    @objc func clickAddProducts(){
        let vc = AddProductsVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func clickEditCategoryBtn(){
       let vc = AddEditCategoryVC()
        vc.selectCategoryModel = self.selCategory ?? CategoryModel(data: [:])
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Delegate & DataSource
extension AdminProductsByCategoryVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
extension AdminProductsByCategoryVC: UICollectionViewDelegateFlowLayout {
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
extension AdminProductsByCategoryVC {
    private func setConstraints(){
        generalCollectionView.fillSuperview()
    }
}


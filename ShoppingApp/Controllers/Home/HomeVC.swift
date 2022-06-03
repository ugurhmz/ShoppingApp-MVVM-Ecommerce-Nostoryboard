//
//  ViewController.swift
//  FurnitureShop
//
//  Created by ugur-pc on 19.05.2022.
//

import UIKit
import Firebase

class HomeVC:  UIViewController {
    
    let otherImgList = ["v1","v2","v3","v4","v5","v6"]
    lazy var  homeViewModel = HomeViewModel()
    lazy var cartVC = CartVC()
    var currentUser: String?
    
    var userCartItemsArr: [CartModel] = []
    
    private let generalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: HomeVC.createCompositionalLayout())
        cv.backgroundColor = .white
        // register
        cv.register(AdvertiseCell.self,
                    forCellWithReuseIdentifier: AdvertiseCell.identifier)
        //header
        cv.register(CellHeaderView.self, forSupplementaryViewOfKind: "header",
                    withReuseIdentifier:   CellHeaderView.identifier)
        // product cells
        cv.register(HomeGreetingHeaderCell.self, forCellWithReuseIdentifier: HomeGreetingHeaderCell.identifier)
        cv.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        cv.register(ProductsOneCell.self, forCellWithReuseIdentifier: ProductsOneCell.identifier)
        cv.register(ProductsTwoCell.self, forCellWithReuseIdentifier: ProductsTwoCell.identifier)
        return cv
    }()
    
    //MARK: - createCompositionalLayout
   static func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
       let mylayout = UICollectionViewCompositionalLayout {  (index, environment) -> NSCollectionLayoutSection? in
           return  HomeVC.createSectionFor(index: index, environment: environment)
        }
        return mylayout
    }
    
    static func createSectionFor(index: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        switch index {
        case 0:
            return createGreetingHeaderSection()
        case 1:
            return createCategoriesSection()
        case 2:
            return createProductsOneSection()
        case 3:
            return createSliderSection()
        case 4:
            return createProductsTwoSection()
        case 5:
            return createProductsOneSection()
        default:
            return  createCategoriesSection()
        }
    }
    
    static func createGreetingHeaderSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets.trailing = 6
            item.contentInsets.leading = 8
       
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(125)), subitems: [item])
       let section = NSCollectionLayoutSection(group: group)
       section.orthogonalScrollingBehavior = .continuous
        // suplementary
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(55))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: "header",
                                                                 alignment: .top)
        section.boundarySupplementaryItems = [header]
       return section
    }
    
    //MARK: - 1 SECTION Categories
    static func createCategoriesSection() -> NSCollectionLayoutSection {
        
        let inset: CGFloat = 1
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.18),
                                              heightDimension: .fractionalHeight(0.38))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10,
                                                     leading: 8,
                                                     bottom: inset,
                                                     trailing: 4)
        item.contentInsets.bottom = -100
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6),
                                               heightDimension: .fractionalHeight(0.22))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem:  item, count: 2)
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        // suplementary
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(55))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: "header",
                                                                 alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
       //MARK: - 2 SECTION Products
       static func createProductsOneSection() -> NSCollectionLayoutSection {
           
           let inset: CGFloat = 3
           // item
           let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4),
                                                 heightDimension: .fractionalHeight(1))
           let item = NSCollectionLayoutItem(layoutSize: itemSize)
           item.contentInsets = NSDirectionalEdgeInsets(top: inset,
                                                        leading: 8,
                                                        bottom: inset,
                                                        trailing: 8)
           // group
           let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                  heightDimension: .fractionalHeight(0.36))
           let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                          subitem:  item, count: 2)
           // section
           let section = NSCollectionLayoutSection(group: group)
           section.orthogonalScrollingBehavior = .continuous
           // suplementary
           let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .absolute(55))
           let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                    elementKind: "header",
                                                                    alignment: .top)
           section.boundarySupplementaryItems = [header]
           return section
       }
    
      //MARK: - Coffes
       static func createProductsTwoSection() -> NSCollectionLayoutSection {
           let inset: CGFloat = 4.5
           // items
           let smallItemSize  = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .fractionalHeight(0.5))
           let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
           smallItem.contentInsets = NSDirectionalEdgeInsets(top: inset,
                                                             leading: 8,
                                                             bottom: 10,
                                                             trailing: 6)
           // group
           let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.50), heightDimension: .fractionalHeight(1))
           let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize,
                                                                subitems: [smallItem])
           
           let horizontalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(0.82))
           let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: horizontalGroupSize, subitems: [verticalGroup])
           // section
           let section = NSCollectionLayoutSection(group: horizontalGroup)
           section.orthogonalScrollingBehavior = .groupPaging
           
           // suplementary
           let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .absolute(62))
           let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                    elementKind: "header",
                                                                    alignment: .top)
           section.boundarySupplementaryItems = [header]
           return section
       }
    
    static func createSliderSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets.trailing = 6
            item.contentInsets.leading = 8
       
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(125)), subitems: [item])
       let section = NSCollectionLayoutSection(group: group)
       section.orthogonalScrollingBehavior = .continuous
        // suplementary
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(55))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: "header",
                                                                 alignment: .top)
        section.boundarySupplementaryItems = [header]
       return section
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        settingsNavigateBar()
        isCurrentUserCheck()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    private func isCurrentUserCheck() {
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously { (result, error) in
                 if let error = error {
                     self.handleFireAuthError(error: error,
                                         fontSize: 24,
                                         textColor: #colorLiteral(red: 0.9254902005, green: 0.3018482075, blue: 0.1536569698, alpha: 1),
                                         bgColor: .white)
                     print(error.localizedDescription)
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      
        
        // When login
        if let user = Auth.auth().currentUser, !user.isAnonymous {
            self.homeViewModel.fetchFavItemsCurrentUser(userId: user.uid)
            self.homeViewModel.fetchCartItemsCurrentUser(userId: user.uid)
            
            self.currentUser = user.email
            let logOutImage = UIImage(systemName: "person.fill.xmark")?.withRenderingMode(.alwaysOriginal)
           navigationItem.leftBarButtonItem = UIBarButtonItem(image: logOutImage, style: .done,
                                                              target: self, action: nil)
            navigationItem.leftBarButtonItem?.action =  #selector(clickLogoutBtn)
            
            if userService.userListener == nil {
                userService.getCurrentUser()
            }
            
        } else {    // When logout
            let loginImage = UIImage(systemName: "person.fill")?.withRenderingMode(.alwaysOriginal)
           navigationItem.leftBarButtonItem = UIBarButtonItem(image: loginImage, style: .done,
                                                              target: self, action: nil)
            navigationItem.leftBarButtonItem?.action =  #selector(clickLoginBtn)
        }
        
        // fetching
        homeViewModel.fetchAllCategoriesData()
       
        self.homeViewModel.favItemCount = { [weak self] in
            guard let self = self else { return }
            if let favCount = self.homeViewModel.favouritesArrList?.count {
                NotificationCenter.default.post(name: NSNotification.Name("notifiFavourite"), object: favCount)
            }
        }
        
        self.homeViewModel.cartData = { [weak self] in
            guard let self = self else { return }
            if let cartItem = self.homeViewModel.fetchCartArrList {
                print("cartItem", cartItem)
                self.userCartItemsArr = cartItem
            }
        }
        
        // reload data with closure
        self.homeViewModel.reloadData = { [weak self] in
            guard let self = self else { return }
            self.generalCollectionView.reloadData()
        }
        
        self.homeViewModel.uniqueCategoryClosure = { [weak self] in
            guard let self = self else { return }
            for item in self.homeViewModel.uniqueCategoryId {
                self.homeViewModel.fetchProducts(getCategoryFilter: item )
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        homeViewModel.realTimeListener?.remove()
        self.generalCollectionView.reloadData()
    }
  
    private func setupViews(){
        [generalCollectionView].forEach{ view.addSubview($0)}
        generalCollectionView.dataSource = self
        generalCollectionView.delegate = self
        generalCollectionView.collectionViewLayout =  HomeVC.createCompositionalLayout()
        setConstraints()
    }
    
    private func settingsNavigateBar() {
        let logOutImage = UIImage(systemName: "person")?.withRenderingMode(.alwaysOriginal)
       // left icon
       navigationItem.leftBarButtonItem = UIBarButtonItem(image: logOutImage, style: .done,
                                                          target: self, action: nil)
        navigationItem.leftBarButtonItem?.action = #selector(clickLogoutBtn)
       // right two icons
        if #available(iOS 13.0, *) {
          let navBarAppearance = UINavigationBarAppearance()
            //navBarAppearance.configureWithDefaultBackground()
           navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange,NSAttributedString.Key.font: UIFont(name: "Charter-Black", size: 26)!]
           
          // navigationController?.navigationBar.barStyle = .black
          //navigationController?.navigationBar.standardAppearance = navBarAppearance
          navigationController?.navigationBar.compactAppearance = navBarAppearance
          navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

          navigationController?.navigationBar.prefersLargeTitles = false
          navigationItem.title = "ShopMe®"
          }
       // icons color
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.3210115628, blue: 0.07575775568, alpha: 1)
    }
}

//MARK: - @objc functions
extension HomeVC {
    
    @objc func clickLoginBtn(){
        let loginVC = LoginVC()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
    }
    // click logout btn
    @objc func clickLogoutBtn(){
        let loginVC = LoginVC()
        loginVC.modalPresentationStyle = .fullScreen

        guard let user = Auth.auth().currentUser else { return }
        
        if user.isAnonymous {
            present(loginVC, animated: true, completion: nil)
        } else {
            do {
                    try Auth.auth().signOut()
                    userService.logoutUser()    // Singleton logout
                
                    Auth.auth().signInAnonymously { result, error in
                        if let error = error {
                            self.handleFireAuthError(error: error,
                                                fontSize: 24,
                                                textColor: #colorLiteral(red: 0.9254902005, green: 0.3018482075, blue: 0.1536569698, alpha: 1),
                                                bgColor: .white)
                            print(error.localizedDescription)
                        }
                        self.present(loginVC, animated: true, completion: nil)
                    }
                
            } catch {
                self.handleFireAuthError(error: error,
                                    fontSize: 25,
                                    textColor: #colorLiteral(red: 0.9254902005, green: 0.3018482075, blue: 0.1536569698, alpha: 1),
                                    bgColor: .white)
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: - Constraints
extension HomeVC {
    private func setConstraints(){
        generalCollectionView.fillSuperview()
    }
}

//MARK: - DataSource
extension HomeVC: UICollectionViewDataSource {
    
    // numberOfSections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        switch section {
        case Sections.HeaderGreetingSection.rawValue:
            return 1
        case Sections.CategoriesSection.rawValue:
            return self.homeViewModel.categoryList?.count ?? 0
        case Sections.AdvertiseSection.rawValue:
            return 10
        case Sections.ProductsOneSection.rawValue:
            return self.homeViewModel.productList?.count ?? 0
        case Sections.ProductsTwoSection.rawValue:
            return self.homeViewModel.productTwoList?.count ?? 0
        case Sections.ProductsThreeSection.rawValue:
            return self.homeViewModel.productThreeList?.count ?? 0
        default :
            return 5
        }
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
            
        case Sections.HeaderGreetingSection.rawValue:
             let greetingCell = generalCollectionView.dequeueReusableCell(withReuseIdentifier: HomeGreetingHeaderCell.identifier, for: indexPath) as! HomeGreetingHeaderCell
            greetingCell.layer.cornerRadius = 20
            greetingCell.layer.borderColor = UIColor.darkGray.cgColor
            greetingCell.layer.borderWidth = 0.4
            greetingCell.layer.shadowColor = UIColor.black.cgColor
            greetingCell.layer.shadowRadius = 12
            greetingCell.layer.shadowPath = CGPath.init(rect: CGRect.init(x: 0, y: 0, width:greetingCell.layer.bounds.width, height: greetingCell.layer.bounds.height),transform: nil)
            greetingCell.layer.shadowOpacity = 7;
            greetingCell.layer.shadowOffset = CGSize(width: 1, height: 1)
            
            if let thisUser = self.currentUser {
                greetingCell.userInfo(data: thisUser)
            }
            
            return greetingCell
        //MARK: - Categories
        case Sections.CategoriesSection.rawValue:
            let categoryCell = generalCollectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
        
            if let categoryValue = self.homeViewModel.categoryList {
                categoryCell.fillCategoryData(category: categoryValue[indexPath.item])
            }
            return categoryCell
            
        //MARK: - Phones
        case Sections.ProductsOneSection.rawValue:
            let cell = generalCollectionView.dequeueReusableCell(withReuseIdentifier: ProductsOneCell.identifier, for: indexPath) as! ProductsOneCell
            
            if let productValue = self.homeViewModel.productList {
                cell.fillData(product: productValue[indexPath.item])
                
                
                // ** ADD FAV CLOSURE **
                cell.addFavClosure = { [weak self] in
                    userService.addFavourites(product: productValue[indexPath.item])
                    self?.generalCollectionView.reloadData()
                }
                
            }
            // ** ADD CART CLOSURE **
            if let val = self.homeViewModel.productList {
                cell.addToCartClosure = { [weak self]  in
                    // 1. TIKLANAN PRODUCT'ı bul.
                        print("TIKLANAN PRD ->", val[indexPath.row].name)
                    //2. Tıklanan prd -> O Userdaki, Cart itemlarında varmı bunu check et.
                    if let allCartArr = self?.userCartItemsArr {
                        cell.checkPrdAndCartItem(clickedPrd: val[indexPath.item],
                                                 allCartItems: allCartArr)
                    }
                }
            }
            
            return cell
            
        //MARK: - Advertise
        case Sections.AdvertiseSection.rawValue:
            
            let cell = generalCollectionView.dequeueReusableCell(withReuseIdentifier: AdvertiseCell.identifier, for: indexPath)
            cell.layer.cornerRadius = 20
            return cell
            
        //MARK: - Phones
        case Sections.ProductsTwoSection.rawValue:
            let cell = generalCollectionView.dequeueReusableCell(withReuseIdentifier: ProductsTwoCell.identifier, for: indexPath) as! ProductsTwoCell
            
            if let productValue = self.homeViewModel.productTwoList {
                cell.fillData(product: productValue[indexPath.item])
                cell.addFavClosure = { [weak self] in
                    userService.addFavourites(product: productValue[indexPath.item])
                    self?.generalCollectionView.reloadData()
                }
            }
            return cell
            
        //MARK: - Dresses
        case Sections.ProductsThreeSection.rawValue:
            let cell = generalCollectionView.dequeueReusableCell(withReuseIdentifier: ProductsOneCell.identifier, for: indexPath) as! ProductsOneCell
            
            if let productValue = self.homeViewModel.productThreeList {
                cell.fillData(product: productValue[indexPath.item])
                cell.addFavClosure = { [weak self] in
                    userService.addFavourites(product: productValue[indexPath.item])
                    self?.generalCollectionView.reloadData()
                }
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    // viewForSupplementaryElementOfKind
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: CellHeaderView.identifier, for: indexPath) as! CellHeaderView
        
        switch indexPath.section {
            case Sections.HeaderGreetingSection.rawValue:
                view.titleLabel.text = ""
            case Sections.CategoriesSection.rawValue:
                view.titleLabel.text = "Categories"
            case Sections.ProductsOneSection.rawValue:
                view.titleLabel.text = "Phones"
            case Sections.ProductsTwoSection.rawValue:
                view.titleLabel.text = "Coffess"
            case Sections.ProductsThreeSection.rawValue:
                view.titleLabel.text = "Dresses"
            case Sections.AdvertiseSection.rawValue:
                view.titleLabel.text = "Advertisements "
            default:
                return UICollectionReusableView()
        }
        return view
    }
}

//MARK: -  ViewDelegate
extension HomeVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = ProductDetailVC()
        
        switch indexPath.section {
            case Sections.CategoriesSection.rawValue:
                let cateVC = ProductsByCategoryVC()
                cateVC.selectCategoryId = self.homeViewModel.categoryList?[indexPath.row].id
                self.navigationController?.pushViewController(cateVC, animated: true)
            
            case Sections.ProductsOneSection.rawValue:
                vc.configure(with: self.homeViewModel.productList?[indexPath.row] ?? ProductModel(data: [:]))
            self.navigationController?.pushViewController(vc, animated: true)
            
            case Sections.ProductsTwoSection.rawValue:
                vc.configure(with: self.homeViewModel.productTwoList?[indexPath.row] ?? ProductModel(data: [:]))
                navigationController?.pushViewController(vc, animated: true)
            
            case Sections.ProductsThreeSection.rawValue:
                vc.configure(with: self.homeViewModel.productThreeList?[indexPath.row] ?? ProductModel(data: [:]))
                navigationController?.pushViewController(vc, animated: true)
            case Sections.AdvertiseSection.rawValue:
            print(indexPath.row)
            default:
               print("")
        }
    }
}

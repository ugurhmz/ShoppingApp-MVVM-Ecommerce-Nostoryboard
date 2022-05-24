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
    
    private let generalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: HomeVC.createCompositionalLayout())
        cv.backgroundColor = .white
        
        // register
        cv.register(UICollectionViewCell.self,
                    forCellWithReuseIdentifier: "cellId")
       
        cv.register(CellHeaderView.self, forSupplementaryViewOfKind: "header", withReuseIdentifier:   CellHeaderView.identifier)
        
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
            return createFirstSection()
        case 1:
            return createSecondSection()
        case 2:
            return createThirdSection()
        case 3:
            return createSecondSection()
        case 4:
            return createSliderSection()
        default:
            return  createFirstSection()
        }
    }
    
    
    //MARK: - 0 SECTION Categories
    static func createFirstSection() -> NSCollectionLayoutSection {
        
        let inset: CGFloat = 1
        
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.18),
                                              heightDimension: .fractionalHeight(0.38))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset,
                                                     leading: inset,
                                                     bottom: inset,
                                                     trailing: inset)
        item.contentInsets.bottom = -100
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6),
                                               heightDimension: .fractionalHeight(0.16))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem:  item, count: 2)
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        
        // suplementary
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(45))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: "header",
                                                                 alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    
    
       //MARK: - 1 SECTION Products
       static func createSecondSection() -> NSCollectionLayoutSection {
           
           let inset: CGFloat = 3
           
           // item
           let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4),
                                                 heightDimension: .fractionalHeight(1))
           
           let item = NSCollectionLayoutItem(layoutSize: itemSize)
           item.contentInsets = NSDirectionalEdgeInsets(top: inset,
                                                        leading: inset,
                                                        bottom: inset,
                                                        trailing: inset)
           
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
                                                   heightDimension: .absolute(45))
           
           let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                    elementKind: "header",
                                                                    alignment: .top)
           section.boundarySupplementaryItems = [header]
           return section
       }
    
      //MARK: - 2 SECTION
       static func createThirdSection() -> NSCollectionLayoutSection {
           let inset: CGFloat = 2.5
           
           // items
           let smallItemSize  = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .fractionalHeight(0.5))
           let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
           smallItem.contentInsets = NSDirectionalEdgeInsets(top: inset,
                                                             leading: inset,
                                                             bottom: inset,
                                                             trailing: inset)
           
           // group
           let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.49), heightDimension: .fractionalHeight(1))
           let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize,
                                                                subitems: [smallItem])
           
           let horizontalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(0.62))
           let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: horizontalGroupSize, subitems: [verticalGroup,verticalGroup, verticalGroup, verticalGroup])
           
           
           // section
           let section = NSCollectionLayoutSection(group: horizontalGroup)
           section.orthogonalScrollingBehavior = .groupPaging
           
           // suplementary
           let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .absolute(44))
           let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                    elementKind: "header",
                                                                    alignment: .top)
           section.boundarySupplementaryItems = [header]
           
           return section
       }
    
    static func createSliderSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                       item.contentInsets.trailing = 32
       
       let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(125)), subitems: [item])
       
       let section = NSCollectionLayoutSection(group: group)
       section.orthogonalScrollingBehavior = .continuous
        
        // suplementary
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(44))
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

        if let user = Auth.auth().currentUser, !user.isAnonymous {

            let logOutImage = UIImage(systemName: "person.fill.xmark")?.withRenderingMode(.alwaysOriginal)

           navigationItem.leftBarButtonItem = UIBarButtonItem(image: logOutImage, style: .done,
                                                              target: self, action: nil)
            navigationItem.leftBarButtonItem?.action =  #selector(clickLogoutBtn)
        } else {
            let loginImage = UIImage(systemName: "person.fill")?.withRenderingMode(.alwaysOriginal)

           navigationItem.leftBarButtonItem = UIBarButtonItem(image: loginImage, style: .done,
                                                              target: self, action: nil)
            navigationItem.leftBarButtonItem?.action =  #selector(clickLoginBtn)
        }
        // fetching
        homeViewModel.fetchCategory()
        homeViewModel.fetchProducts()
        
    }

  
    private func setupViews(){
        [generalCollectionView].forEach{ view.addSubview($0)}
        generalCollectionView.dataSource = self
        generalCollectionView.delegate = self
        generalCollectionView.collectionViewLayout =  HomeVC.createCompositionalLayout()
        setConstraints()
        
        // reload data with closure
        self.homeViewModel.reloadData = { [weak self] in
            guard let self = self else { return }
            self.generalCollectionView.reloadData()
        }
    }
    
    
    private func settingsNavigateBar() {
        let logOutImage = UIImage(systemName: "person.fill.xmark")?.withRenderingMode(.alwaysOriginal)
        
       // left icon
       navigationItem.leftBarButtonItem = UIBarButtonItem(image: logOutImage, style: .done,
                                                          target: self, action: nil)
        
        navigationItem.leftBarButtonItem?.action = #selector(clickLogoutBtn)
       // right two icons
       navigationItem.rightBarButtonItems = [
           UIBarButtonItem(image: UIImage(systemName: "cart.fill"),
                           style: .done, target: self, action: nil),
           
           UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .done,
                               target: self, action: nil)
       ]
       
        if #available(iOS 13.0, *) {
          let navBarAppearance = UINavigationBarAppearance()
          //navBarAppearance.configureWithOpaqueBackground()
           navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,NSAttributedString.Key.font: UIFont(name: "Charter-Black", size: 26)!]
         
           navigationController?.navigationBar.barStyle = .black
          navigationController?.navigationBar.standardAppearance = navBarAppearance
          navigationController?.navigationBar.compactAppearance = navBarAppearance
          navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

          navigationController?.navigationBar.prefersLargeTitles = false
          navigationItem.title = "ShopMe®"
          
          }
       // icons color
       navigationController?.navigationBar.tintColor = .black
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
        print("logout")
        let loginVC = LoginVC()
        loginVC.modalPresentationStyle = .fullScreen

        guard let user = Auth.auth().currentUser else { return }
        
        if user.isAnonymous {
            present(loginVC, animated: true, completion: nil)
        } else {
            do {
                  try Auth.auth().signOut()
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
        return 5
    }
    
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return self.homeViewModel.categoryList?.count ?? 0
        }
        
        if section == 1 {
            return self.homeViewModel.productList?.count ?? 0
        }
        return section == 2 ?  15 : 5
    }
    
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = generalCollectionView.dequeueReusableCell(withReuseIdentifier: "cellId",
                                                             for: indexPath)
        
        // RANDOM COLORS
        cell.backgroundColor =   UIColor(hue: CGFloat(drand48()),
                                         saturation: 1,
                                         brightness: 1,
                                         alpha: 1)
        cell.layer.cornerRadius = 10
        // Category Cell
        if indexPath.section == 0 {
            let categoryCell = generalCollectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
            
                
            if let categoryValue = self.homeViewModel.categoryList {
                categoryCell.fillCategoryData(category: categoryValue[indexPath.item])
            }
            
            return categoryCell
        }
        
        // Popular Furnitures Cell
        if indexPath.section == 1 {
            let cell = generalCollectionView.dequeueReusableCell(withReuseIdentifier: ProductsOneCell.identifier, for: indexPath) as! ProductsOneCell
            
            
            if let productValue = self.homeViewModel.productList {
                cell.fillData(product: productValue[indexPath.item])
            }
            
            
            return cell
        }
        
        // Popular Furnitures Cell
        if indexPath.section == 2 {
            let cell = generalCollectionView.dequeueReusableCell(withReuseIdentifier: ProductsTwoCell.identifier, for: indexPath) as! ProductsTwoCell
            
            
//            if let productValue = self.productViewModel.productList {
//                cell.fillData(product: productValue[indexPath.item])
//            }
            // RANDOM COLORS
            cell.backgroundColor =   UIColor(hue: CGFloat(drand48()),
                                             saturation: 1,
                                             brightness: 1,
                                             alpha: 1)
            
            return cell
        }
        
        return cell
    }
    
    
    // viewForSupplementaryElementOfKind
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: CellHeaderView.identifier, for: indexPath) as! CellHeaderView
        
        
        if indexPath.section == 0 {
            view.titleLabel.text = "Categories"
        }
        if indexPath.section == 1{
            view.titleLabel.text = "Furnitures"
        }
        if indexPath.section == 2 {
            view.titleLabel.text = "Elbiseler"
        }
        
        if indexPath.section == 3 {
            view.titleLabel.text = "Beyaz Eşya"
        }
        
        if indexPath.section == 4 {
            view.titleLabel.text = "Slider"
        }
        
        return view
    }
     
}


//MARK: -  ViewDelegate
extension HomeVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            print(indexPath.row)
        }
    }
}

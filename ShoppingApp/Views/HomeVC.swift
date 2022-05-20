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
    
    
    private let generalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: HomeVC.createCompositionalLayout())
        cv.backgroundColor = .white
        
        // register
        cv.register(UICollectionViewCell.self,
                    forCellWithReuseIdentifier: "cellId")
       
        cv.register(HeaderReusableView.self, forSupplementaryViewOfKind: "header", withReuseIdentifier:   HeaderReusableView.identifier)
        
        cv.register(ZeroCustomCell.self, forCellWithReuseIdentifier: ZeroCustomCell.identifier)
        cv.register(OneCustomCell.self, forCellWithReuseIdentifier: OneCustomCell.identifier)
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
        default:
            return  createFirstSection()
        }
    }
    
    
    //MARK: - 0 SECTION
    static func createFirstSection() -> NSCollectionLayoutSection {
        
        let inset: CGFloat = 1
        
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.18),
                                              heightDimension: .fractionalHeight(0.18))
        
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
    
    
    
       //MARK: - 1 SECTION
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
                                                  heightDimension: .fractionalHeight(0.25))
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
        let largeItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                   heightDimension: .fractionalHeight(1))
        let largeItem = NSCollectionLayoutItem(layoutSize: largeItemSize)
        largeItem.contentInsets = NSDirectionalEdgeInsets(top: inset,
                                                          leading: inset,
                                                          bottom: inset,
                                                          trailing: inset)
        
        // group
        let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25),
                                                       heightDimension: .fractionalHeight(1))
        let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize,
                                                             subitems: [smallItem])
        
        let horizontalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                         heightDimension: .fractionalHeight(0.4))
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: horizontalGroupSize, subitems: [largeItem, verticalGroup, verticalGroup])
        
        
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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        settingsNavigateBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let _ = Auth.auth().currentUser {

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
    }

    @objc func clickLoginBtn(){
        let loginVC = LoginVC()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
    }
    
    private func setupViews(){
        [generalCollectionView].forEach{ view.addSubview($0)}
        generalCollectionView.dataSource = self
        generalCollectionView.delegate = self
        generalCollectionView.collectionViewLayout =  HomeVC.createCompositionalLayout()
        setConstraints()
      
    }
    
    
    // click logout btn
    @objc func clickLogoutBtn(){
        print("logout")
        let loginVC = LoginVC()
        loginVC.modalPresentationStyle = .fullScreen


        if let _ = Auth.auth().currentUser {
            do {
                try Auth.auth().signOut()

                present(loginVC, animated: true, completion: nil)
            } catch {
                print(error.localizedDescription)
            }
        } else {
            //navigationController?.pushViewController(LoginVC(), animated: true)
            present(loginVC, animated: true, completion: nil)

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
        return 3
    }
    
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return otherImgList.count
        }
        
        if section == 1 {
            return otherImgList.count
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
        
        if indexPath.section == 0 {
            let cell = generalCollectionView.dequeueReusableCell(withReuseIdentifier: ZeroCustomCell.identifier, for: indexPath) as! ZeroCustomCell
            
            otherImgList.forEach({ item in
                cell.imgView.image = UIImage(named: "\(otherImgList[indexPath.row])")
                
            })
            
            
            return cell
        }
        
        if indexPath.section == 1 {
            let cell = generalCollectionView.dequeueReusableCell(withReuseIdentifier: OneCustomCell.identifier, for: indexPath) as! OneCustomCell
            
            
            otherImgList.forEach({ item in
                cell.imgView.image = UIImage(named: "\(otherImgList[indexPath.row])")
                
            })
            
            return cell
        }
        
        return cell
    }
    
    
    // viewForSupplementaryElementOfKind
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: HeaderReusableView.identifier, for: indexPath) as! HeaderReusableView
        
        
        if indexPath.section == 0 {
            view.titleLabel.text = "Categories"
        }
        if indexPath.section == 1{
            view.titleLabel.text = "Popular Furnitures"
        }
        if indexPath.section == 2 {
            view.titleLabel.text = "All Products"
        }
        
        
        
        return view
    }
     
}


//MARK: - 
extension HomeVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            print(indexPath.row)
        }
    }
}

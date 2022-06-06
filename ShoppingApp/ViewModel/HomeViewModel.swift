//
//  ProductViewModel.swift
//  ShoppingApp
//
//  Created by ugur-pc on 24.05.2022.
//

import Foundation
import FirebaseFirestore

protocol HomeViewModelProtocol {
    var productList: [ProductModel]? { get set}
    var categoryList: [CategoryModel]? { get set}
}

final class HomeViewModel: HomeViewModelProtocol {
    
    var productList: [ProductModel]? = []
    var productTwoList: [ProductModel]? = []
    var productThreeList: [ProductModel]? = []
    var adminArrList: [ProductModel]? = []
    var favouritesArrList: [ProductModel]? = []
    var fetchCartArrList: [CartModel]? = []
    var reloadData: VoidClosure?
    var cartData: VoidClosure?
    var uniqueCategoryClosure: VoidClosure?
    var favItemCount: VoidClosure?
    var categoryList: [CategoryModel]? = []
    var realTimeListener: ListenerRegistration?
    var db: Firestore?
    var uniqueCategoryId = Set<String>()
    private var keyword: String?
    var filteredOneList:  [ProductModel]? = []
    var searchRefresh: VoidClosure?
    var searchMode = false
    var cartItemCount: VoidClosure?
    var sumUsertCartItem = 0
    var clickDataClosure: VoidClosure?
    
    
    var clickedCartItemArr: [ProductModel] = []
    var prdDatas = [ProductModel]()
    
    init(){
        db = Firestore.firestore()
    }
}


//MARK: -
extension HomeViewModel {
    
    //MARK: - FETCH ALL PRODUCTS
    func fetchProducts(getCategoryFilter: String){
  
        let productRef = db?.collection("products").whereField("category", isEqualTo: "\(getCategoryFilter)")
        
        realTimeListener = productRef?.addSnapshotListener { (snap, error) in
            guard let documents = snap?.documents else {
                SnackHelper.showSnack(message: "Database Error!. Product are unavailable.", bgColor: .white, textColor: .red, viewHeight: 170, msgDuration: 0.6)
                return
            }
            
            switch getCategoryFilter {
            case "RvGTTdx7PE99wEI7Oq8j":
                self.productList?.removeAll()
                    for document in documents {
                        let data =  document.data()
                        let newProductArr = ProductModel.init(data: data)
                        self.productList?.append(newProductArr)
                    }
            case "nDVHEA5e8p0pLJzWyAR8":
                self.productTwoList?.removeAll()
                    for document in documents {
                        let data =  document.data()
                        let newProductArr = ProductModel.init(data: data)
                        self.productTwoList?.append(newProductArr)
                    }
            case "a4uHOjGK1uyqUjzLkSeD":
                self.productThreeList?.removeAll()
                for document in documents {
                    let data =  document.data()
                    let newProductArr = ProductModel.init(data: data)
                    self.productThreeList?.append(newProductArr)
                }
            default:
                return
            }
            self.reloadData?()
        }
    }
    
    //MARK: - FETCH ALL PRODUCTS
    func fetchCategoryToProducts(getCategoryFilter: String){
  
        let productRef = db?.collection("products").whereField("category", isEqualTo: "\(getCategoryFilter)")
        
        realTimeListener = productRef?.addSnapshotListener { (snap, error) in
            
            guard let documents = snap?.documents else {
                SnackHelper.showSnack(message: "Database Error!. Product are unavailable.", bgColor: .white, textColor: .red, viewHeight: 170, msgDuration: 0.6)
                return
            }
            self.adminArrList?.removeAll()
            for document in documents {
                let data =  document.data()
                let newProductArr = ProductModel.init(data: data)
                self.adminArrList?.append(newProductArr)
            }
            self.reloadData?()
        }
    }
    
 
    //MARK: -  FETCH ALL CATEGORIES (RealTime)
    func fetchAllCategoriesData(){
        
        let categoriesRef = db?.collection("categories").whereField("isActive", isEqualTo: true).order(by: "timeStamp")
        
        realTimeListener = categoriesRef?.addSnapshotListener { (snap, error) in
            guard let documents = snap?.documents else {
                SnackHelper.showSnack(message: " Database Error!. Categories are unavailable.", bgColor: .white, textColor: .red, viewHeight: 170, msgDuration: 0.6)
                return
            }
            self.categoryList?.removeAll()
            for document in documents {
                let data =  document.data()
                let newCategoryArr = CategoryModel.init(data: data)
                self.categoryList?.append(newCategoryArr)
                self.uniqueCategoryId.insert(newCategoryArr.id)
            }
            self.reloadData?()
            self.uniqueCategoryClosure?()
        }
    }
    
    
    //MARK: - FETCH BY ID Products To Category
    func fetchCategoryToProductsWithId(filterById: String){
  
        let productRef = db?.collection("products").whereField("category", isEqualTo: "\(filterById)")
        
        realTimeListener = productRef?.addSnapshotListener { (snap, error) in
            guard let documents = snap?.documents else {
                SnackHelper.showSnack(message: "Database Error!. Product are unavailable.", bgColor: .white, textColor: .red, viewHeight: 170, msgDuration: 0.6)
                return
            }
            self.adminArrList?.removeAll()
            for document in documents {
                let data =  document.data()
                let newProductArr = ProductModel.init(data: data)
                self.adminArrList?.append(newProductArr)
            }
            self.reloadData?()
        }
    }
    
    
    //MARK: - FETCH FAVOURITES
    func fetchFavItemsCurrentUser(userId: String){
        let  favRef = db?.collection("users").document(userId).collection("favourites")
        realTimeListener = favRef?.addSnapshotListener { (snap, error) in
            guard let documents = snap?.documents else {
                SnackHelper.showSnack(message: " Database Error!. Favourites are unavailable.", bgColor: .white, textColor: .red, viewHeight: 170, msgDuration: 0.6)
                return
            }
            self.favouritesArrList?.removeAll()
            for document in documents {
                let data =  document.data()
                let favouriteModel = ProductModel.init(data: data)
                self.favouritesArrList?.append(favouriteModel)
            }
            self.reloadData?()
            self.favItemCount?()
            
        }
    }
    
    //MARK: - FETCH FAVOURITES
    func fetchCartItemsCurrentUser(userId: String){
        let  favRef = db?.collection("users").document(userId).collection("newcarts")
        
        realTimeListener = favRef?.addSnapshotListener { (snap, error) in
            
            guard let documents = snap?.documents else {
                SnackHelper.showSnack(message: " Database Error!. Favourites are unavailable.", bgColor: .white, textColor: .red, viewHeight: 170, msgDuration: 0.6)
                return
            }
            self.fetchCartArrList?.removeAll()
            
            for document in documents {
                let data =  document.data()
                let cartModel = CartModel.init(data: data)
                self.fetchCartArrList?.append(cartModel)
            }
            
            self.sumUsertCartItem = 0
            self.fetchCartArrList?.forEach({
                self.sumUsertCartItem += $0.quantity
            })
            
           // self.reloadData?()
            self.cartItemCount?()
            self.cartData?()
        }
    }
    
    //MARK: - FETCH BY ID Products To Category
    func fetchProductWithId(filterById: String){
  
        let productRef = db?.collection("products").whereField("id", isEqualTo: "\(filterById)")
        
        realTimeListener = productRef?.addSnapshotListener { (snap, error) in
            guard let documents = snap?.documents else {
                SnackHelper.showSnack(message: "Database Error!. Product are unavailable.", bgColor: .white, textColor: .red, viewHeight: 170, msgDuration: 0.6)
                return
            }
           
            for document in documents {
                let data =  document.data()
                let newProductArr = ProductModel.init(data: data)
                self.clickedCartItemArr.append(newProductArr)
            }
            
            
            self.clickDataClosure?()
        }
    }
    
    
}

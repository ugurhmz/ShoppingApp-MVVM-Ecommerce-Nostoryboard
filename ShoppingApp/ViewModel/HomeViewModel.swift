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
enum CategoriesType: String {
        case phones = "phones"
        case coffees = "coffees"
}
final class HomeViewModel: HomeViewModelProtocol {
    
   
    
    var productList: [ProductModel]? = []
    var productTwoList: [ProductModel]? = []
    var reloadData: VoidClosure?
    var categoryList: [CategoryModel]? = []
    var realTimeListener: ListenerRegistration?
    var db: Firestore?
   // private var categoriesType: CategoriesType?
    
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
            case "phones":
                self.productList?.removeAll()
                    for document in documents {
                        let data =  document.data()
                        let newProductArr = ProductModel.init(data: data)
                        self.productList?.append(newProductArr)
                       
                    }
                case "coffees":
                self.productTwoList?.removeAll()
                    for document in documents {
                        let data =  document.data()
                        let newProductArr = ProductModel.init(data: data)
                        self.productTwoList?.append(newProductArr)
                        
                    }
                default:
                return
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
             
            }
            self.reloadData?()
        }
    }
}
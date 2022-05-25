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
    var productList: [ProductModel]?
    var reloadData: VoidClosure?
    var categoryList: [CategoryModel]? = []
    var realTimeListener: ListenerRegistration?
    var db: Firestore?
    
    init(){
        db = Firestore.firestore()
    }
    
    //MARK: - FETCH ALL PRODUCTS
    func fetchProducts(){
        let productData = [ ProductModel(id: "1", name: "Eşya", category: "abc", price: 3.15, productOverview: "lorem ipsum",
              imageUrl: "https://images.unsplash.com/photo-1653044290058-e829e1df14f8?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxNXx8fGVufDB8fHx8&auto=format&fit=crop&w=500",
                   timeStamp: Timestamp(),
                    stock: 15)]
        
        self.productList = productData
        self.reloadData?()
    } 
    
 
    //MARK: -  FETCH ALL CATEGORIES (RealTime)
    func fetchAllCategoriesData(){
        
        let categoriesRef = db?.collection("categories").whereField("isActive", isEqualTo: true).order(by: "timeStamp")
        
        realTimeListener = categoriesRef?.addSnapshotListener { (snap, error) in
            guard let documents = snap?.documents else {
                SnackHelper.showSnack(message: "Categories are unavailable. Database Error!", bgColor: .white, textColor: .red, viewHeight: 170, msgDuration: 0.6)
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

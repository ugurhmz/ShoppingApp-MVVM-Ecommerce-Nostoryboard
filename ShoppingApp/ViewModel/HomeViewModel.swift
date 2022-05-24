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
    var categoryList: [CategoryModel]?
    
    var db: Firestore?
    
    init(){
        db = Firestore.firestore()
    }
    
    func fetchProducts(){
        let productData = [ ProductModel(id: "1", name: "Eşya", category: "abc", price: 3.15, productOverview: "lorem ipsum",
              imageUrl: "https://images.unsplash.com/photo-1653044290058-e829e1df14f8?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxNXx8fGVufDB8fHx8&auto=format&fit=crop&w=500",
                   timeStamp: Timestamp(),
                    stock: 15,
                    favoritePrd: false)]
        
        self.productList = productData
        self.reloadData?()
    }
  
    
    func fetchCategory(){
       
        
        let docRef = db?.collection("categories").document("RvGTTdx7PE99wEI7Oq8j")
        
        docRef?.getDocument { (snap, error) in
            guard let data = snap?.data() else {
                SnackHelper.showSnack(message: "Categories are unavailable. Database Error!", bgColor: .white, textColor: .red, viewHeight: 170, msgDuration: 0.6)
                return
            }
            
            let id = data["id"] as? String ?? ""
            let name = data["name"] as? String ?? ""
            let imgUrl = data["imgUrl"] as? String ?? ""
            let isActive = data["isActive"] as? Bool ?? true
            let timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp()
            
            let newCategory = [CategoryModel.init(id: id, name: name, imgUrl: imgUrl, isActive: isActive, timeStamp: timeStamp)]
            
            self.categoryList = newCategory
            self.reloadData?()
        }
    }
}






//MARK: - Dummy datas example
/*
func fetchCategory(){
    let categoryData = [CategoryModel.init(id: "qweq", name: "Nature", imgUrl: "https://images.unsplash.com/photo-1653194132914-eff329b9043a?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1472", timeStamp: Timestamp()),
       CategoryModel.init(id: "qweq", name: "Nature", imgUrl: "https://images.unsplash.com/photo-1653194132914-eff329b9043a?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1472", timeStamp: Timestamp()),

        CategoryModel.init(id: "qweq", name: "Retain Cycle Go Retain Cycle Go", imgUrl: "https://images.unsplash.com/photo-1653044290058-e829e1df14f8?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxNXx8fGVufDB8fHx8&auto=format&fit=crop&w=500", timeStamp: Timestamp()),

    CategoryModel.init(id: "qweq", name: "Future", imgUrl: "https://images.unsplash.com/photo-1653044290058-e829e1df14f8?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxNXx8fGVufDB8fHx8&auto=format&fit=crop&w=500", timeStamp: Timestamp())

    ]

    self.categoryList = categoryData
    self.reloadData?()
}
*/

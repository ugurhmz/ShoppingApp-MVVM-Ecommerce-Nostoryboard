//
//  ProductViewModel.swift
//  ShoppingApp
//
//  Created by ugur-pc on 24.05.2022.
//

import Foundation
import FirebaseFirestore

protocol ProductViewModelProtocol {
    var productList: [ProductModel]? { get set}
}

final class ProductViewModel: ProductViewModelProtocol {
    var productList: [ProductModel]?
    var reloadData: VoidClosure?
    
    func fetchProducts(){
        let productData = [ ProductModel(id: "1", name: "Eşya", category: "abc", price: 3.15, productOverview: "lorem ipsum",
              imageUrl: "https://images.unsplash.com/photo-1653044290058-e829e1df14f8?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxNXx8fGVufDB8fHx8&auto=format&fit=crop&w=500",
                   timeStamp: Timestamp(),
                    stock: 15,
                    favoritePrd: false)]
        
        self.productList = productData
        self.reloadData?()
    }
  
}

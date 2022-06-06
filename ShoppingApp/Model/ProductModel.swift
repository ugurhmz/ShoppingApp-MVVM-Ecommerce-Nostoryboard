//
//  ProductModel.swift
//  ShoppingApp
//
//  Created by ugur-pc on 24.05.2022.
//

import Foundation
import FirebaseFirestore

struct ProductModel {
    var id: String
    var name: String
    var category: String
    var price: Double
    var productOverview: String
    var imageUrl: String
    var timeStamp: Timestamp
    var stock: Int
    
    
    init(id: String,
         name: String,
         category: String,
         price: Double,
         productOverview: String,
         imageUrl: String,
         timeStamp: Timestamp,
         stock: Int
    
    ){
        self.id = id
        self.name = name
        self.category = category
        self.price = price
        self.productOverview = productOverview
        self.imageUrl = imageUrl
        self.timeStamp = timeStamp
        self.stock = stock
    }
    
    init(data: [String: Any]) {
        id = data["id"] as? String ?? UUID().uuidString
        name = data["name"] as? String ?? ""
        category = data["category"] as? String ?? ""
        price = data["price"] as? Double ?? 0.0
        productOverview = data["productOverview"] as? String ?? ""
        imageUrl = data["imageUrl"] as? String ?? ""
        timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp()
        stock = data["stock"] as? Int ?? 0
    }
    
    static func modelToData(product: ProductModel) -> [String: Any] {
        let data: [String: Any] = [
            "id" : product.id,
            "name" : product.name,
            "category" : product.category,
            "price" : product.price,
            "productOverview" : product.productOverview,
            "imageUrl" : product.imageUrl,
            "timeStamp" : product.timeStamp,
            "stock" : product.stock
        ]
        
        return data
    }
}


//MARK: -
extension ProductModel: Equatable {
    static func == (lhs: ProductModel, rhs: ProductModel) -> Bool {
        return (lhs.id == rhs.id && lhs.name == rhs.name)
    }
}

//
//  CartModel.swift
//  ShoppingApp
//
//  Created by ugur-pc on 1.06.2022.
//

import Foundation

import Firebase

final class CartModel {
    var cartId: String
    var prdId: String
    var name: String
    var category: String
    var price: Double
    var productOverview: String
    var imageUrl: String
    var timeStamp: Timestamp
    var stock: Int
    var quantity: Int
    
    init(data: [String: Any]) {
        cartId = data["cartId"] as? String ?? UUID().uuidString
        prdId = data["prdId"] as? String ?? UUID().uuidString
        name = data["name"] as? String ?? ""
        category = data["category"] as? String ?? ""
        price = data["price"] as? Double ?? 0.0
        productOverview = data["productOverview"] as? String ?? ""
        imageUrl = data["imageUrl"] as? String ?? ""
        timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp()
        stock = data["stock"] as? Int ?? 0
        quantity = data["quantity"] as? Int ?? 0
    }
   
    
    static func modelToData(myquantity: Int, product: ProductModel) -> [String: Any] {
        let data: [String: Any] = [
            "cartId":   UUID().uuidString,
            "prdId" : product.id,
            "name" : product.name,
            "category" : product.category,
            "price" : product.price,
            "productOverview" : product.productOverview,
            "imageUrl" : product.imageUrl,
            "timeStamp" : product.timeStamp,
            "stock" : product.stock,
            "quantity": myquantity
        ]
        
        return data
    }
   
    // FOR +,- CLICK QUANTITY 
    static func modelToDataTwo(myquantity: Int, cartPrd: CartModel) -> [String: Any] {
        let data: [String: Any] = [
            "cartId":   UUID().uuidString,
            "prdId" : cartPrd.prdId,
            "name" : cartPrd.name,
            "category" : cartPrd.category,
            "price" : cartPrd.price,
            "productOverview" : cartPrd.productOverview,
            "imageUrl" : cartPrd.imageUrl,
            "timeStamp" : cartPrd.timeStamp,
            "stock" : cartPrd.stock,
            "quantity": myquantity
        ]
        
        return data
    }
}

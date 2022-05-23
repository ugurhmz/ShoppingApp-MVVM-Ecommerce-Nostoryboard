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
    var favoritePrd: Bool
}

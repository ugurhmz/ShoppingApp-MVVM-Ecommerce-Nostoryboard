//
//  CategoryModel.swift
//  ShoppingApp
//
//  Created by ugur-pc on 21.05.2022.
//

import Foundation
import FirebaseFirestore

struct CategoryModel {
    var id: String
    var name: String
    var imgUrl: String
    var isActive: Bool = true
    var timeStamp: Timestamp
}

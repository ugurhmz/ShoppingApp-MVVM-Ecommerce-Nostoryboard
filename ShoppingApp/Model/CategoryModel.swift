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
    
    init(data: [String: Any]){
        
        self.id = data["id"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.imgUrl = data["imgUrl"] as? String ?? ""
        self.isActive = data["isActive"] as? Bool ?? true
        self.timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp()
    }
}

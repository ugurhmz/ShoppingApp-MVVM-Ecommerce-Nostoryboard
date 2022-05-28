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
    
    init(id: String,
         name: String,
         imgUrl: String,
         isActive: Bool = true,
         timeStamp: Timestamp)
    {
        self.id = id
        self.name = name
        self.imgUrl = imgUrl
        self.isActive = isActive
        self.timeStamp = timeStamp
    }
    
    
    init(data: [String: Any]){
        
        self.id = data["id"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.imgUrl = data["imgUrl"] as? String ?? ""
        self.isActive = data["isActive"] as? Bool ?? true
        self.timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp()
    }
    
    static func modelToData(category: CategoryModel) -> [String: Any] {
        let data: [String: Any] = [
            "id": category.id,
            "name" : category.name,
            "imgUrl": category.imgUrl,
            "isActive": category.isActive,
            "timeStamp": category.timeStamp
        ]
        
        return data
        
    }
}

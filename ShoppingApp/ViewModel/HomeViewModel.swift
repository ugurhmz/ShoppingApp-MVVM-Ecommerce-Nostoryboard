//
//  HomeViewModel.swift
//  ShoppingApp
//
//  Created by ugur-pc on 21.05.2022.
//

import Foundation
import FirebaseFirestore


protocol HomeViewModelProtocol {
    var categoryList: [CategoryModel]? { get set}
}

final class HomeViewModel: HomeViewModelProtocol {
  
    
    
    var categoryList: [CategoryModel]?
    var reloadData: VoidClosure?
    
    
    func fetchCategory(){
        let categoryData = [CategoryModel.init(id: "qweq", name: "Nature", imgUrl: "https://images.unsplash.com/photo-1653044290058-e829e1df14f8?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxNXx8fGVufDB8fHx8&auto=format&fit=crop&w=500", timeStamp: Timestamp()),
           CategoryModel.init(id: "qweq", name: "Nature", imgUrl: "https://images.unsplash.com/photo-1653044290058-e829e1df14f8?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxNXx8fGVufDB8fHx8&auto=format&fit=crop&w=500", timeStamp: Timestamp()),
                            
            CategoryModel.init(id: "qweq", name: "Retain Cycle Go Retain Cycle Go", imgUrl: "https://images.unsplash.com/photo-1653044290058-e829e1df14f8?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxNXx8fGVufDB8fHx8&auto=format&fit=crop&w=500", timeStamp: Timestamp()),
        
        CategoryModel.init(id: "qweq", name: "Future", imgUrl: "https://images.unsplash.com/photo-1653044290058-e829e1df14f8?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxNXx8fGVufDB8fHx8&auto=format&fit=crop&w=500", timeStamp: Timestamp())
            
        ]
        
        self.categoryList = categoryData
        self.reloadData?()
    }
}

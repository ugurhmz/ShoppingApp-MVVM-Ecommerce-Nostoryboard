//
//  UserService.swift
//  ShoppingApp
//
//  Created by ugur-pc on 31.05.2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

let userService = UserService()

final class UserService {
    
    var userModel = UserModel()
    var favourites = [ProductModel]()
    let auth = Auth.auth()
    let db = Firestore.firestore()
    var userListener: ListenerRegistration? = nil
    var favsListener: ListenerRegistration? = nil
    
    
    //MARK: - GUEST USER
    var isGuestUser: Bool {
        guard let authUser = auth.currentUser else {
            return true
        }
        
        if authUser.isAnonymous {
            return true
        } else {
            return false
        }
    }
    
    
    //MARK: - CURRENT USER
    func getCurrentUser(){
        guard let authUser = auth.currentUser else { return }
        
        let userRef = db.collection("users").document(authUser.uid)
        userListener = userRef.addSnapshotListener({ (snap, error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = snap?.data() else { return }
            self.userModel = UserModel.init(data: data)
        })
        
        
        // favourites
        let favsRef = userRef.collection("favourites")
        favsListener = favsRef.addSnapshotListener({ ( snap, error ) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            snap?.documents.forEach({ (document) in
                let favourite = ProductModel.init(data: document.data())
                self.favourites.append(favourite)
            })
        })
    }
    
    //MARK: - ADDED FAVOURITES
    func addFavourites(product: ProductModel){
        let favsRef = Firestore.firestore().collection("users").document(userModel.id).collection("favourites")
        
        
        if favourites.contains(product){ // when contains then remove it.
            favourites.removeAll {
                $0 == product
            }
            favsRef.document(product.id).delete()
            
        } else {                        // when !contains then add it.
            favourites.append(product)
            let data = ProductModel.modelToData(product: product)
            favsRef.document(product.id).setData(data)
            
        }
    }
    
    //MARK: - LOGOUT
    func logoutUser(){
        userListener?.remove()
        userListener = nil
        favsListener?.remove()
        favsListener = nil
        userModel = UserModel()
        favourites.removeAll()
    }
}

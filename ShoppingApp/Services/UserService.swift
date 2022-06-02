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
    var cartItems = [ProductModel]()
    let auth = Auth.auth()
    let db = Firestore.firestore()
    var userListener: ListenerRegistration? = nil
    var favsListener: ListenerRegistration? = nil
    var addToCartListener: ListenerRegistration? = nil
    var cartArr = [CartModel]()
    
    var quantity: Int = 0
    
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
        
        // cart
        let cartRef = userRef.collection("newcarts")
        addToCartListener = cartRef.addSnapshotListener({  snap, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            snap?.documents.forEach({ (document) in
                let item = CartModel.init(data: document.data())
                self.cartArr.append(item)
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
    
    
    //MARK: -  ADD TO CART
    func addToCart(count: Int,product: ProductModel){
        print("userService", count)
        let cartRef = Firestore.firestore().collection("users").document(userModel.id).collection("newcarts")
            
        let data =  CartModel.modelToData(myquantity: count, product: product)
        cartRef.document(product.id).setData(data)
    }
    
    
    
    //MARK: - LOGOUT
    func logoutUser(){
        userListener?.remove()
        userListener = nil
        favsListener?.remove()
        addToCartListener?.remove()
        favsListener = nil
        userModel = UserModel()
        favourites.removeAll()
        cartItems.removeAll()
    }
}

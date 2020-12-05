//
//  WishlistManager.swift
//  What to Catch
//
//  Created by Esteban Mundo on 5/17/20.
//  Copyright © 2020 Mundo Inc. All rights reserved.
//

import Foundation

class WishlistManager{
    static let sharedInstance = WishlistManager()
    
    var wishlist = [String]()
    
    public func checkWishlist(current : Animal) -> Bool{
        for animal in wishlist {
            if(current.name == animal){
                    return true
            }
        }
        return false
    }
    public func addAnimal(to_add : Animal){
        
        wishlist.append(to_add.name);
        let userDefaults = UserDefaults.standard;
        userDefaults.set(wishlist, forKey: "AnimalArray")
    }
    public func removeAnimal(to_remove: Animal){
        // Get Index of animal
        for (index, animal) in wishlist.enumerated() {
            if(animal == to_remove.name){
                wishlist.remove(at: index)
                return
            }
        
        }
    }
    // INITIALIZATION
    private init(){
        let data = UserDefaults.standard.array(forKey: "AnimalArray") as? [String]
        if(data == nil){
            wishlist = []
        } else {
            wishlist = data!
        }
        
       // wishlist = UserDefaults.standard.object(forKey: "Animals") as! [Animal]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

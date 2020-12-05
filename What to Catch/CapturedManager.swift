//
//  CapturedManager.swift
//  What to Catch
//
//  Created by Esteban Mundo on 5/18/20.
//  Copyright © 2020 Mundo Inc. All rights reserved.
//

import Foundation

class CapturedManager{
    static let capturedAnimals = CapturedManager()
    
    var captured = [String]()
    
    public func checkCaptured(current : Animal) -> Bool{
        for animal in captured {
            if(current.name == animal){
                    return true
            }
        }
        return false
    }
    public func addAnimal(to_add : Animal){
        
        captured.append(to_add.name);
        let userDefaults = UserDefaults.standard;
        userDefaults.set(captured, forKey: "CapturedAnimalArray")
    }
    public func removeAnimal(to_remove: Animal){
        // Get Index of animal
        for (index, animal) in captured.enumerated() {
            if(animal == to_remove.name){
                captured.remove(at: index)
                return
            }
        
        }
    }
    // INITIALIZATION
    private init(){
        let data = UserDefaults.standard.array(forKey: "CapturedAnimalArray") as? [String]
        if(data == nil){
            captured = []
        } else {
            captured = data!
        }

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

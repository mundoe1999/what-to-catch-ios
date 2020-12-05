//
//  SpecificAnimalViewController.swift
//  What to Catch
//
//  Created by Esteban Mundo on 5/17/20.
//  Copyright © 2020 Mundo Inc. All rights reserved.
//

import UIKit
import AVFoundation

class SpecificAnimalViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var start_time: UILabel!
    @IBOutlet weak var end_time: UILabel!
    
    @IBOutlet weak var wishlistButton: UIButton!
    @IBOutlet weak var capturedButton: UIButton!
    
    var animal : Animal?
    var added_wishlist : Bool = false
    var added_captured : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        name.text = animal?.name
        money.text = String((animal?.price)!)
        start_time.text = self.IntToStringHour(hour: (animal?.start)!)
        end_time.text = self.IntToStringHour(hour: (animal?.end)!)
        
        // Initialize Time variable
    
        if(WishlistManager.sharedInstance.checkWishlist(current: animal!)){
            wishlistButton.setTitle("Remove Wishlist", for: .normal)
            added_wishlist = true
        }
        if(CapturedManager.capturedAnimals.checkCaptured(current: animal!)){
            capturedButton.setTitle("Remove Wishlist", for: .normal)
            added_captured = true
        }
    }
    
    private func IntToStringHour(hour: Int) -> String {
        var s: String = ""
        var time : Int = hour
        if(hour < 12){
            if(hour == 0){ time += 12 }
            s = "\(time):00 AM"
        } else {
            if(hour == 12){ time += 12}
            s = "\(time-12):00 PM"
        }
        
        
        return s
    }
    
    @IBAction func AddToCaptured(_ sender: Any) {
        let message : String
        if(added_captured){
            CapturedManager.capturedAnimals.removeAnimal(to_remove: animal!)
            capturedButton.setTitle("Capture Animal", for: .normal)
            message = "Successfully Removed \(animal?.name ?? "") from your captured list."
            AudioServicesPlaySystemSound(SystemSoundID(1112))
            
            self.added_captured = false
        } else {
            CapturedManager.capturedAnimals.addAnimal(to_add: animal!)
            capturedButton.setTitle("Free Animal", for: .normal)
            message = "Successfully Added \(animal?.name ?? "") to your captured list!"
            AudioServicesPlaySystemSound(SystemSoundID(1111))
            self.added_captured = true
        }
        
        let alert = UIAlertController(title: "Captured!", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func AddToWishlist(_ sender: Any) {
        //let systemSoundID : SystemSoundID = 1016
        let message : String
        if(added_wishlist){
            WishlistManager.sharedInstance.removeAnimal(to_remove: animal!)
            wishlistButton.setTitle("Add to Wishlist", for: .normal)
            message = "Successfully Removed \(animal?.name ?? "") to your wishlist."
            AudioServicesPlaySystemSound(SystemSoundID(1112))
            
            self.added_wishlist = false
        } else {
            WishlistManager.sharedInstance.addAnimal(to_add: animal!)
            wishlistButton.setTitle("Remove Wishlist", for: .normal)
            message = "Successfully Added \(animal?.name ?? "") to your wishlist!"
            AudioServicesPlaySystemSound(SystemSoundID(1111))
            self.added_wishlist = true
        }
        
        let alert = UIAlertController(title: "Wishlist", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
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

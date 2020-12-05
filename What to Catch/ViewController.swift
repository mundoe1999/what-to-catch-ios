//
//  ViewController.swift
//  What to Catch
//
//  Created by Esteban Mundo on 5/12/20.
//  Copyright © 2020 Mundo Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sort_price: UISwitch!
    @IBOutlet weak var current: UISwitch!
    var getCurrentTime : Bool = false;
    var getSortedPrice : Bool = false;
    var animalType : String = "ALL"
    
    @IBOutlet weak var cloud_1: UIImageView!
    @IBOutlet weak var how_to_use: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimations()
        print(WishlistManager.sharedInstance.wishlist)
        // Do any additional setup after loading the view.
    }

    @IBAction func get_all(_ sender: Any) {
        self.animalType = "ALL"
        performSegue(withIdentifier: "animal_view", sender: self)
    }
    @IBAction func get_fish(_ sender: Any) {
        self.animalType = "FISH"
        performSegue(withIdentifier: "animal_view", sender: self)
    }
    @IBAction func get_bug(_ sender: Any) {
        self.animalType = "BUGS"
        performSegue(withIdentifier: "animal_view", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             let vc = segue.destination as! AnimalTableViewController
        vc.getWhatAnimal = self.animalType
        vc.currentTime = self.current.isOn
        vc.priceSort = self.sort_price.isOn
    }
    
    func setupAnimations(){
        //let colorview = UIView()
        //view.addSubview(colorview)
        UIView.animate(withDuration: 8, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.cloud_1.frame.origin.x += 200
        }, completion: nil)
    }
}


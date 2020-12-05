//
//  AnimalTableViewController.swift
//  What to Catch
//
//  Created by Esteban Mundo on 5/17/20.
//  Copyright © 2020 Mundo Inc. All rights reserved.
//

import SwiftUI

struct Animal: Decodable {
    let id: Int
    let name : String
    let start: Int
    let end: Int
    let price: Int

    
}



class AnimalTableViewController : UITableViewController {
    private var AnimalArray = [Animal]()
    private var loading = true
    public var getWhatAnimal : String = "ALL"
    public var currentTime : Bool = false
    public var priceSort : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad();
        getAnimal(get_type: getWhatAnimal, time: currentTime)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if loading {
            return 1
        } else {
            return AnimalArray.count
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showAnimal", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SpecificAnimalViewController {
            destination.animal = AnimalArray[(tableView.indexPathForSelectedRow?.row)!]
        }
        
        tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalCell", for: indexPath)
        
        if loading {
            cell.textLabel?.text = "Loading..."
        } else {
            let animal = AnimalArray[indexPath.row]
            cell.textLabel?.text = animal.name
            cell.detailTextLabel?.text = String(animal.price)
            
            if(WishlistManager.sharedInstance.checkWishlist(current: animal)){
                cell.contentView.backgroundColor = UIColor.yellow
            }
            if(CapturedManager.capturedAnimals.checkCaptured(current: animal)) {
                cell.contentView.backgroundColor = UIColor.green
            }
            else {
                cell.contentView.backgroundColor = UIColor.white
            }

        }
        
        return cell
    }
 
    
    // get_type => ["ALL","BUGS,"FISH"]

    private func getAnimal(get_type: String, time: Bool){
        var apiAddress = "https://acnh-what-to-catch.herokuapp.com"
        
        // Gets the specified Type that is selected
        switch get_type {
        case "ALL":
            apiAddress+="/"
            break;
        case "BUGS":
            apiAddress+="/bugs"
            break;
        case "FISH":
            apiAddress+="/fish"
        default:
            break;
        }
        
       apiAddress += "?sort=\(priceSort)"
        
        // Check if time needs to be added
        if(time){
            /*Get Current Time*/
            let date = Date();
            let calendar = Calendar.current
            
            // Get Hour and month
            let hour = calendar.component(.hour, from: date)
            let month = calendar.component(.month, from: date)-1
            apiAddress += "&hour=\(hour)&month=\(month)"

        }
        
        print(apiAddress)
        
        // Do API request
        guard let url = URL(string: apiAddress) else {return}
        let session = URLSession.shared
        session.dataTask(with: url, completionHandler: { (data, res, err) in
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(Array<Animal>.self, from: data)
                    self.AnimalArray = json
                } catch {
                    print(error)
                }
                self.loading = false
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
            }).resume()
    }
}

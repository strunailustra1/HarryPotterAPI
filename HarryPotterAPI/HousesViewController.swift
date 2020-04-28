//
//  HousesViewController.swift
//  HarryPotterAPI
//
//  Created by Наталья Мирная on 27.04.2020.
//  Copyright © 2020 Наталья Мирная. All rights reserved.
//

import UIKit

class HousesViewController: UITableViewController {

    let activityLabel = UIActivityIndicatorView(style: .medium)
    var houses: [House] = []
  
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.fetchHouses(housesVC: self)
        tableView.backgroundView = activityLabel
        activityLabel.hidesWhenStopped = true
        activityLabel.startAnimating()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        houses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "houseCell", for: indexPath)
        cell.textLabel?.text = houses[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let house = houses[indexPath.row]
        performSegue(withIdentifier: "showHouse", sender: house)
    }
  
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHouse" {
            let detailVC = segue.destination as! DetailHouseViewController
            detailVC.house = sender as? House
        }
    }
}

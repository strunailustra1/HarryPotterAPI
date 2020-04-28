//
//  NetworkManager.swift
//  HarryPotterAPI
//
//  Created by Наталья Мирная on 27.04.2020.
//  Copyright © 2020 Наталья Мирная. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    let housesUrl = "https://www.potterapi.com/v1/houses"
    let charactersUrl = "https://www.potterapi.com/v1/characters"
    
    let potterApiKey = "$2a$10$z8wYV.kWtQbLI9HKLsXTC.tkRPQz4/6rJ4LTKrWbA9Rdfs/IKqQPS"
    let url1 = "https://www.potterapi.com/v1/houses?key=$2a$10$z8wYV.kWtQbLI9HKLsXTC.tkRPQz4/6rJ4LTKrWbA9Rdfs/IKqQPS"
    let url2 = "https://www.potterapi.com/v1/characters?key=$2a$10$z8wYV.kWtQbLI9HKLsXTC.tkRPQz4/6rJ4LTKrWbA9Rdfs/IKqQPS"
    

    func fetchHouses(housesVC: HousesViewController ) {
        guard let url = URL(string: url1) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let houses = try decoder.decode([House].self, from: data)
                housesVC.houses = houses
                
                DispatchQueue.main.async {
                    housesVC.activityLabel.stopAnimating()
                    housesVC.tableView.reloadData()
                }
                
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    func fetchCharacters() {
        
    }
}



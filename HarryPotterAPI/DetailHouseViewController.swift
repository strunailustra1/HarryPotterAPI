//
//  DetailHouseViewController.swift
//  HarryPotterAPI
//
//  Created by Наталья Мирная on 28.04.2020.
//  Copyright © 2020 Наталья Мирная. All rights reserved.
//

import UIKit

class DetailHouseViewController: UIViewController {
    
    @IBOutlet weak var houseNameLabel: UILabel!
    @IBOutlet weak var mascotNameLabel: UILabel!
    @IBOutlet weak var colorsHouseLabel: UILabel!
    @IBOutlet weak var valuesLabel: UILabel!
    @IBOutlet weak var founderLabel: UILabel!
    @IBOutlet weak var houseGhostLabel: UILabel!
    @IBOutlet weak var headOfHouseLabel: UILabel!
    var house: House!

    override func viewDidLoad() {
        super.viewDidLoad()
      //  houseNameLabel.text = house.name
        mascotNameLabel.text = house.mascot
        colorsHouseLabel.text = house.colors?.joined(separator: ", ")
        valuesLabel.text = house.values?.joined(separator: ", ")
        founderLabel.text = house.founder
        headOfHouseLabel.text = house.headOfHouse
        houseGhostLabel.text = house.houseGhost
        
        navigationItem.title = house.name
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

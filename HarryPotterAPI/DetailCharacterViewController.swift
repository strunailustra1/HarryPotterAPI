//
//  DetailCharacterViewController.swift
//  HarryPotterAPI
//
//  Created by Наталья Мирная on 06.05.2020.
//  Copyright © 2020 Наталья Мирная. All rights reserved.
//

import UIKit

class DetailCharacterViewController: UIViewController {
    
    var character: Character!
    
    @IBOutlet weak var houseLabel: UILabel!
    @IBOutlet weak var schoolLabel: UILabel!
    @IBOutlet weak var ministryOfMagicLabel: UILabel!
    @IBOutlet weak var orderOfThePhoenix: UILabel!
    @IBOutlet weak var deathEaterLabel: UILabel!
    @IBOutlet weak var dumbledoresArmyLabel: UILabel!
    @IBOutlet weak var wandNameLabel: UILabel!
    @IBOutlet weak var patronusNameLabel: UILabel!
    @IBOutlet weak var boggartNameLabel: UILabel!
    @IBOutlet weak var animagusNameLabel: UILabel!
    @IBOutlet weak var wandLabel: UILabel!
    @IBOutlet weak var boggartLabel: UILabel!
    @IBOutlet weak var patronusLabel: UILabel!
    @IBOutlet weak var animagusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        houseLabel.text = character.house
        schoolLabel.text = character.school
        ministryOfMagicLabel.text = character.ministryOfMagic ?? false ? "yes" : "no"
        orderOfThePhoenix.text = character.orderOfFenix ?? false ? "yes" : "no"
        deathEaterLabel.text = character.deathEater ?? false ? "yes" : "no"
        dumbledoresArmyLabel.text = character.dumbledoresArmy ?? false ? "yes" : "no"
        //  wandLabel.text = character.wand != nil ? character.wand : "unknown"
        if let _ = character.wand {
            wandNameLabel.text = character.wand
        } else {
            wandLabel.isHidden = true
            wandNameLabel.isHidden = true
        }
        
        boggartNameLabel.text = character.boggart != nil ? character.boggart : "unknown"
        animagusNameLabel.text = character.animagus != nil ? character.animagus : "unknown"
        navigationItem.title = character.name
        //  patronusNameLabel.text = character.patronus != nil ? character.patronus : "unknown"
        guard let _ = character.patronus else {
            patronusLabel.isHidden = true
            patronusNameLabel.isHidden = true
            return
        }
        patronusNameLabel.text = character.patronus
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

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
    @IBOutlet weak var memberLabel: UILabel!
    @IBOutlet weak var bloodStatusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
//    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var aliasLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = character.name
//        nameLabel.text = character.name
        aliasLabel.text = character.alias
        houseLabel.text = character.house
        schoolLabel.text = character.school
        roleLabel.text = character.role?.lowercased()
        bloodStatusLabel.text = character.bloodStatus
        speciesLabel.text = character.species
        hideLabels()
    }
    
    private func hideLabels() {
        if character.ministryOfMagic == false,
            character.orderOfThePhoenix == false,
            character.dumbledoresArmy == false,
            character.deathEater == false {
            memberLabel.isHidden = true
        }
        
        if character.ministryOfMagic == true {
            ministryOfMagicLabel.isHidden = false
        } else {
            ministryOfMagicLabel.isHidden = true
        }
        
        if character.orderOfThePhoenix == true {
            orderOfThePhoenix.isHidden = false
        } else {
            orderOfThePhoenix.isHidden = true
        }
        
        if character.dumbledoresArmy == true {
            dumbledoresArmyLabel.isHidden = false
        } else {
            dumbledoresArmyLabel.isHidden = true
        }
        
        if character.deathEater == true {
            deathEaterLabel.isHidden = false
        } else {
            deathEaterLabel.isHidden = true
        }
        
        if let _ = character.wand {
            wandNameLabel.text = character.wand
        } else {
            wandLabel.isHidden = true
            wandNameLabel.isHidden = true
        }
        
        if let _ = character.boggart {
            boggartNameLabel.text = character.boggart
        } else {
            boggartNameLabel.isHidden = true
            boggartLabel.isHidden = true
        }
        
        if let _ = character.animagus {
            animagusNameLabel.text = character.animagus
        } else {
            animagusNameLabel.isHidden = true
            animagusLabel.isHidden = true
        }
        
        if let _ = character.patronus {
            patronusNameLabel.text = character.patronus
        } else {
            patronusNameLabel.isHidden = true
            patronusLabel.isHidden = true
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

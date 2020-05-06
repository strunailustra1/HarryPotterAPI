//
//  CharacterViewController.swift
//  HarryPotterAPI
//
//  Created by Наталья Мирная on 06.05.2020.
//  Copyright © 2020 Наталья Мирная. All rights reserved.
//

import UIKit

class CharactersViewController: UITableViewController {
    
    var characters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.fetchCharacters(charactersVC: self)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "charCell", for: indexPath) as! CharacterViewCell
        cell.nameLabel.text = characters[indexPath.row].name
        cell.aliasLabel.text = characters[indexPath.row].alias
        cell.roleLabel.text = characters[indexPath.row].role
        cell.bloodStatusLabel.text = characters[indexPath.row].bloodStatus
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        performSegue(withIdentifier: "showCharacter", sender: character)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCharacter" {
            let characterVC = segue.destination as! DetailCharacterViewController
            characterVC.character = sender as? Character
        }
    }
}

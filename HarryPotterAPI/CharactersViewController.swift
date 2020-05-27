//
//  CharacterViewController.swift
//  HarryPotterAPI
//
//  Created by Наталья Мирная on 06.05.2020.
//  Copyright © 2020 Наталья Мирная. All rights reserved.
//

import UIKit

class CharactersViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    let activityLabel = UIActivityIndicatorView(style: .medium)
    let searchController = UISearchController(searchResultsController: nil)
    
    var charactersForTable: [Character]? = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var charactersFromApi: [Character] = []
    var searchTokens: [UISearchToken] = []
    
    var isShowSearchTokens: Bool {
        charactersForTable == nil
    }
    
    var searchHouses: [String] {
        let tokens = searchController.searchBar.searchTextField.tokens
        return tokens.compactMap {
            ($0.representedObject as? Houses)?.description
        }
    }
    
    var isSearchingByTokens: Bool {
        return
            searchController.isActive &&
                searchController.searchBar.searchTextField.tokens.count > 0
    }
    
    var isSearchingByName: Bool {
        return searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
    }
    
    var loadCharactersOnLoad = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if loadCharactersOnLoad {
            NetworkManager.shared.fetchCharacters(charactersVC: self)
        }
        
        setNavigationController()
        setActivityIndicator()
        setSearchBar()
        makeTokens()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isShowSearchTokens ? searchTokens.count : charactersForTable?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !isShowSearchTokens,
            let cell = tableView.dequeueReusableCell(withIdentifier: "charCell", for: indexPath) as? CharacterViewCell {
            cell.nameLabel.text = charactersForTable?[indexPath.row].name
            cell.aliasLabel.text = charactersForTable?[indexPath.row].alias
            cell.roleLabel.text = charactersForTable?[indexPath.row].role
            cell.bloodStatusLabel.text = charactersForTable?[indexPath.row].bloodStatus
            return cell
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: "houseCellChar", for: indexPath) as? SearchTokenViewCell {
            cell.token = searchTokens[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isShowSearchTokens {
            didSelect(token: searchTokens[indexPath.row])
        } else {
            let character = charactersForTable?[indexPath.row]
            performSegue(withIdentifier: "showCharacter", sender: character)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCharacter" {
            let characterVC = segue.destination as! DetailCharacterViewController
            characterVC.character = sender as? Character
        }
    }

    // MARK: - Search
    func searchFor(_ searchText: String?) {
        guard searchController.isActive else { return }
        guard let searchText = searchText else {
            charactersForTable = nil
            return
        }
        let selectedBloodStatus = selectedScopeBloodStatus()
        let filteredCharacters = charactersFromApi.filter { (character) -> Bool in
            let isMatchingBloodStatus = selectedBloodStatus == BloodStatus.noType.description ?
                true : (character.bloodStatus == selectedBloodStatus)
            let isMatchingTokens = searchHouses.count == 0 ? true : searchHouses.contains(character.house ?? "")
            
            if !searchText.isEmpty {
                return
                    isMatchingBloodStatus &&
                        isMatchingTokens &&
                        (character.name?.lowercased().contains(searchText.lowercased()) ?? false)
            } else if isSearchingByTokens {
                return isMatchingBloodStatus && isMatchingTokens
            }
            return false
        }
        charactersForTable = filteredCharacters.count > 0 ? filteredCharacters : nil
        print("Установили charactersForTable = " + String(charactersForTable?.count ?? 0) + " штук")
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.searchTextField.isFirstResponder {
            
            if (!isSearchingByTokens && !isSearchingByName && searchController.isActive) {
                charactersForTable = nil
            }
        } else {
            charactersForTable = charactersFromApi
            searchController.searchBar.searchTextField.backgroundColor = nil
        }
        
        if let house = searchController.searchBar.searchTextField.tokens.first?.representedObject as? Houses {
            searchController.searchBar.searchTextField.tokenBackgroundColor = UIColor(cgColor: house.colorOfHouse)
            searchController.searchBar.searchTextField.backgroundColor = UIColor(cgColor: house.colorOfHouse).withAlphaComponent(0.1)
            searchController.searchBar.searchTextField.textColor = UIColor(cgColor: house.colorOfHouse)
        }
    }
    
    // - MARK: SearchBar
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        guard let searchText = searchController.searchBar.text else { return }
        searchFor(searchText)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchFor(searchText)
        let showScope = !searchText.isEmpty
        showScopeBar(showScope)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        charactersForTable = nil
        showScopeBar(false)
    }
    
    func setSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Name"
        searchController.searchBar.delegate = self
        searchController.automaticallyShowsScopeBar = false
        navigationItem.searchController = searchController
        searchController.searchBar.scopeButtonTitles = BloodStatus.allCases.map {$0.description}
        searchController.searchBar.setScopeBarButtonTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Didot", size: 8.0) as Any ], for: UIControl.State.normal)
    }
    
    func showScopeBar(_ show: Bool) {
        guard searchController.searchBar.showsScopeBar != show else { return }
        searchController.searchBar.setShowsScope(show, animated: true)
        view.setNeedsLayout()
    }
    
    func selectedScopeBloodStatus() -> String {
        guard let scopeButtonTitles = searchController.searchBar.scopeButtonTitles else {
            return BloodStatus.noType.description
        }
        return scopeButtonTitles[searchController.searchBar.selectedScopeButtonIndex]
    }
    
    func didSelect(token: UISearchToken) {
        let searchTextField = searchController.searchBar.searchTextField
        searchTextField.insertToken(token, at: searchTextField.tokens.count)
        searchFor(searchController.searchBar.text)
        showScopeBar(true)
    }
        
    private func setActivityIndicator() {
        tableView.backgroundView = activityLabel
        activityLabel.hidesWhenStopped = true
        activityLabel.startAnimating()
    }
    
    private func setNavigationController() {
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Academy Engraved LET", size: 22.0)!]
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension CharactersViewController {
    func makeTokens() {
        let houses = Houses.allCases
        searchTokens = houses.map { (house) -> UISearchToken in
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 23, height: 21))
            label.textAlignment = .center
            label.text = house.iconOfHouse
            label.sizeToFit()
            let tokenImage = UIImage.imageWithLabel(label: label)
            let token = UISearchToken(icon: tokenImage, text: house.description)
            token.representedObject = Houses(rawValue: house.description)
            return token
        }
    }
}

extension UIImage {
    class func imageWithLabel(label: UILabel) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0.0)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
   }
}



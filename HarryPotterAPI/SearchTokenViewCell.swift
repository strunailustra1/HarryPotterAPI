//
//  SearchTokenViewCell.swift
//  HarryPotterAPI
//
//  Created by Наталья Мирная on 14.05.2020.
//  Copyright © 2020 Наталья Мирная. All rights reserved.
//

import UIKit

class SearchTokenViewCell: UITableViewCell {

  //  @IBOutlet weak var tokenImage: UIImageView!
    @IBOutlet weak var tokenLabel: UILabel!
    @IBOutlet weak var tokenIcon: UILabel!
    var token: UISearchToken! {
      didSet {
        guard let house = token?.representedObject as? Houses else {
          return
        }
        tokenLabel.text = "Search by \(house.description)"
        tokenIcon.text = house.iconOfHouse //UIImage(contentsOfFile: house.iconOfHouse)
      //  tokenImage.image = UIImage(contentsOfFile: house.iconOfHouse)
//        tokenImage.image = UIImage(systemName: "house.fill")
//        tokenImage.tintColor = UIColor(cgColor: house.colorOfHouse)
      }
    }
}

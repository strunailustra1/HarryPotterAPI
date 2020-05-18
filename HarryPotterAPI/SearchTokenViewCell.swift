//
//  SearchTokenViewCell.swift
//  HarryPotterAPI
//
//  Created by Наталья Мирная on 14.05.2020.
//  Copyright © 2020 Наталья Мирная. All rights reserved.
//

import UIKit

class SearchTokenViewCell: UITableViewCell {

    @IBOutlet weak var tokenImage: UIImageView!
    @IBOutlet weak var tokenLabel: UILabel!

    var token: UISearchToken! {
      didSet {
        guard let house = token?.representedObject as? String else {
          return
        }
        tokenLabel.text = "Search by \(house)"
        tokenImage.image = UIImage(systemName: "house.fill")
      //  tokenImage.tintColor = .clear
      }
    }
}

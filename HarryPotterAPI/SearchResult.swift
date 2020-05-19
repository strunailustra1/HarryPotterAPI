//
//  SearchResult.swift
//  HarryPotterAPI
//
//  Created by Наталья Мирная on 27.04.2020.
//  Copyright © 2020 Наталья Мирная. All rights reserved.
//
import UIKit

struct SearchResult: Decodable {
    let house: [House]?
    let character: [Character]?
}

struct House: Decodable {
    let id: String?
    let name: String?
    let mascot : String?
    let headOfHouse: String?
    let houseGhost: String
    let founder: String?
    let v: Int?
    let school: String?
    let members: [String]?
    let values: [String]?
    let colors: [String]?
    
    var emoji: String {
        let mascotType = MascotType(rawValue: mascot ?? "") ?? MascotType.unknown
        return mascotType.icon
    }
    
    var emojiBackground: CGColor {
        let mascotType = MascotType(rawValue: mascot ?? "") ?? MascotType.unknown
        return mascotType.colorOfIcon
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case v = "__v"
        case name = "name"
        case mascot = "mascot"
        case headOfHouse = "headOfHouse"
        case houseGhost = "houseGhost"
        case founder = "founder"
        case school = "school"
        case members = "members"
        case values = "values"
        case colors = "colors"
    }
}

struct Character: Decodable {
    let id: String?
    let name: String?
    let role: String?
    let house: String?
    let school: String?
    let v: Int?
    let ministryOfMagic: Bool?
    let orderOfThePhoenix: Bool?
    let dumbledoresArmy: Bool?
    let deathEater: Bool?
    let bloodStatus: String?
    let species: String?
    let alias: String?
    let patronus: String?
    let wand: String?
    let boggart: String?
    let animagus: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case v = "__v"
        case name = "name"
        case role = "role"
        case house = "house"
        case school = "school"
        case ministryOfMagic = "ministryOfMagic"
        case orderOfThePhoenix = "orderOfThePhoenix"
        case dumbledoresArmy = "dumbledoresArmy"
        case deathEater = "deathEater"
        case bloodStatus = "bloodStatus"
        case species = "species"
        case alias = "alias"
        case patronus = "patronus"
        case wand = "wand"
        case boggart = "boggart"
        case animagus = "animagus"
    }
    
    var fullName: String? {
        "\(name ?? "")  \(alias ?? "")"
    }
}

enum MascotType: String {
    case lion = "lion"
    case eagle = "eagle"
    case serpent = "serpent"
    case badger = "badger"
    
    case unknown = "unknown"
    
    var icon: String {
        switch self {
        case .lion:
            return "🦁"
        case .eagle:
            return "🦅"
        case .serpent:
            return "🐍"
        case .badger:
            return "🦡"
        case .unknown:
            return "❓"
        }
    }
    
    var colorOfIcon: CGColor {
        switch self {
        case .lion:
            return CGColor(srgbRed: 175/255, green: 34/255, blue: 36/255, alpha: 1.0)
        case .eagle:
            return CGColor(srgbRed: 45/255, green: 123/255, blue: 215/255, alpha: 1.0)
        case .serpent:
            return CGColor(srgbRed: 0/255, green: 94/255, blue: 53/255, alpha: 1.0)
        case .badger:
            return CGColor(srgbRed: 215/255, green: 187/255, blue: 71/255, alpha: 1.0)
        case .unknown:
            return CGColor(srgbRed: 190/255, green: 60/255, blue: 36/255, alpha: 1.0)
        }
    }
}

enum BloodStatus: String, CaseIterable {
    case noType = "all"
    case pureBlood = "pure-blood"
    case halfBlood = "half-blood"
    case unknown = "unknown"
    case mugleBorn = "muggle-born"
    
    var description: String {
        rawValue.description
    }
}

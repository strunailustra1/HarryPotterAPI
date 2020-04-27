//
//  SearchResult.swift
//  HarryPotterAPI
//
//  Created by Наталья Мирная on 27.04.2020.
//  Copyright © 2020 Наталья Мирная. All rights reserved.
//

struct SearchResult: Decodable {
    let house: [House]?
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
    let orderOfFenix: Bool?
    let dumbledoresArmy: Bool?
    let deathEater: Bool?
    let bloodStatus: String?
    let species: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case v = "__v"
        case name = "name"
        case role = "role"
        case house = "house"
        case school = "school"
        case ministryOfMagic = "ministryOfMagic"
        case orderOfFenix = "orderOfFenix"
        case dumbledoresArmy = "dumbledoresArmy"
        case deathEater = "deathEater"
        case bloodStatus = "bloodStatus"
        case species = "species"
    }
}


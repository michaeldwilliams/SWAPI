//
//  Person.swift
//  SWAPI
//
//  Created by Michael Williams on 4/12/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import Foundation

struct Person {
    let name: String
    let height: Int
    let mass: Int
    let hairColor: String
    let skinColor: String
    let eyeColor: String
    let birthYear: String
    let gender: String
    let homeWorldURL: URL
    let filmURLs: [URL]
    let speciesURL: [URL]
    let vehiclesURLs: [URL]
    let starShipsURLs: [URL]
    let url: URL
    
    static func from(json: [String:Any]) -> Person? {
        guard let name = json["name"] as? String else { return nil }
        guard let heightString = json["height"] as? String,
            let height = Int(heightString) else { return nil }
        guard let massString = json["mass"] as? String,
            let mass = Int(massString) else { return nil }
        guard let hairColor = json["hair_color"] as? String else { return nil }
        guard let skinColor = json["skin_color"] as? String else { return nil }
        guard let eyeColor = json["eye_color"] as? String else { return nil }
        guard let birthYear = json["birth_year"] as? String else { return nil }
        guard let gender = json["gender"] as? String else { return nil }
        guard let homeWorldURLString = json["homeworld"] as? String,
            let homeWorldURL = URL(string: homeWorldURLString) else { return nil }
        guard let filmURLStrings = json["films"] as? [String] else { return nil }
        guard let speciesURLStrings = json["species"] as? [String] else { return nil }
        guard let vehiclesURLStrings = json["vehicles"] as? [String] else { return nil }
        guard let starshipsURLStrings = json["starships"] as? [String] else { return nil }
        guard let urlString = json["url"] as? String, let url = URL(string: urlString) else { return nil }
        
        return Person(name: name,
                      height: height,
                      mass: mass,
                      hairColor: hairColor,
                      skinColor: skinColor,
                      eyeColor: eyeColor,
                      birthYear: birthYear,
                      gender: gender,
                      homeWorldURL: homeWorldURL,
                      filmURLs: filmURLStrings.flatMap(URL.init(string:)),
                      speciesURL: speciesURLStrings.flatMap(URL.init(string:)),
                      vehiclesURLs: vehiclesURLStrings.flatMap(URL.init(string:)),
                      starShipsURLs: starshipsURLStrings.flatMap(URL.init(string:)),
                      url: url)
    }
}

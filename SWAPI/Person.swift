//
//  Person.swift
//  SWAPI
//
//  Created by Michael Williams on 4/12/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import Foundation
import Freddy

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

}

extension Person: JSONDecodable {
    init(json: JSON) throws {
        name = try json.getString(at: "name")
        height = Int(try json.getString(at: "height"))!
        mass = Int(try json.getString(at: "mass"))!
        hairColor = try json.getString(at: "hair_color")
        skinColor = try json.getString(at: "skin_color")
        eyeColor = try json.getString(at: "eye_color")
        birthYear = try json.getString(at: "birth_year")
        gender = try json.getString(at: "gender")
        homeWorldURL = URL(string: try json.getString(at: "homeworld"))!
        filmURLs = try json.getArray(at: "films").flatMap { URL(string: try $0.getString()) }
        speciesURL = try json.getArray(at: "species").flatMap { URL(string: try $0.getString()) }
        vehiclesURLs = try json.getArray(at: "vehicles").flatMap { URL(string: try $0.getString()) }
        starShipsURLs = try json.getArray(at: "starships").flatMap { URL(string: try $0.getString()) }
        url = URL(string: try json.getString(at: "url"))!
    }
}

extension Person: Equatable {
    static func == (lhs:Person, rhs:Person) -> Bool {
        return lhs.name == rhs.name &&
            lhs.height == rhs.height &&
            lhs.mass == rhs.mass &&
            lhs.hairColor == rhs.hairColor &&
            lhs.skinColor == rhs.skinColor &&
            lhs.eyeColor == rhs.eyeColor &&
            lhs.birthYear == rhs.birthYear &&
            lhs.gender == rhs.gender &&
            lhs.homeWorldURL == rhs.homeWorldURL &&
            lhs.filmURLs == rhs.filmURLs &&
            lhs.speciesURL == rhs.speciesURL &&
            lhs.vehiclesURLs == rhs.vehiclesURLs &&
            lhs.starShipsURLs == rhs.starShipsURLs &&
            lhs.url == rhs.url
    }
}

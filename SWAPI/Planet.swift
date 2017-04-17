//
//  Planet.swift
//  SWAPI
//
//  Created by Michael Williams on 4/17/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import Foundation
import Freddy

struct Planet: Equatable {
    let climate:String
    let diameter:Int
    let films:[URL]
    let name:String
    let terrain:String
    let population:Int
    let url: URL
    
    static func ==(lhs: Planet, rhs: Planet) -> Bool {
        return lhs.climate == rhs.climate &&
    lhs.diameter == rhs.diameter &&
    lhs.films == rhs.films &&
    lhs.name == rhs.name &&
    lhs.terrain == rhs.terrain &&
    lhs.population == rhs.population &&
    lhs.url == rhs.url
    }
}

extension Planet: JSONDecodable {
    init(json: JSON) throws {
        climate = try json.getString(at: "climate")
        diameter = try json.getInt(at: "diameter")
        films = try json.getArray(at: "films").flatMap { URL(string: try $0.getString()) }
        name = try json.getString(at: "name")
        terrain = try json.getString(at: "terrain")
        do {
            population = try json.getInt(at: "population")
        } catch JSON.Error.valueNotConvertible(let json, let theType) {
            if let value = try? json.getString(), value == "unknown", theType == Int.self {
                population = 0
            } else {
                throw JSON.Error.valueNotConvertible(value: json, to: theType)
            }
        } catch {
            throw error
        }
        url = URL(string: try json.getString(at: "url"))!
    }
}

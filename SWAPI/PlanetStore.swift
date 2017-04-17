//
//  PlanetStore.swift
//  SWAPI
//
//  Created by Michael Williams on 4/17/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import Foundation
import Freddy

class PlanetStore {
    private(set) var planets = [Planet]()
    private var client = HTTPClient()
    
    private func add(_ planet:Planet) {
        guard !planets.contains(planet) else { return }
        planets.append(planet)
    }
    
    func cachedPlanet(for person:Person) -> Planet? {
        return planets.filter({$0.url == person.homeWorldURL}).first
    }
    
    func fetchPlanet(for person: Person, completion: @escaping (Planet?, Error?) -> Void) {
        if let planet = cachedPlanet(for: person) {
            completion(planet, nil)
            return
        }
        
        client.fetchHomeWorld(for: person) { (data, response, error) in
            guard let data = data else { return }
            do {
                let json = try JSON(data: data)
                let planet = try Planet(json: json)
                self.add(planet)
                completion(planet, nil)
            } catch {
                completion(nil, error)
            }
        }
    }

    func fetchPlanets(for people: [Person], completion: @escaping ([Planet], [Error]) -> Void) {
        let uniquePeople = peopleWithUniqueHomeWorlds(from: people)
        
        var planets = [Planet]()
        var errors = [Error]()
        
        let dg = DispatchGroup()
        for person in uniquePeople {
            dg.enter()
            fetchPlanet(for: person) { (planet, error) in
                if let error = error {
                    errors.append(error)
                    dg.leave()
                    return
                }
                guard let planet = planet else {
                    dg.leave()
                    return
                }
                planets.append(planet)
                dg.leave()
            }
        }
        dg.notify(queue: .main) {
            completion(planets, errors)
        }
        
    }


}

private extension PlanetStore {
    func peopleWithUniqueHomeWorlds(from people: [Person]) -> [Person] {
        var uniqueURLs = Set(people.map { $0.homeWorldURL })
        
        return people.filter {
            if uniqueURLs.contains($0.homeWorldURL) {
                uniqueURLs.remove($0.homeWorldURL)
                return true
            } else {
                return false
            }
        }
    }
}

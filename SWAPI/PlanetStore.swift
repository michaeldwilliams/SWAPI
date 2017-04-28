//
//  PlanetStore.swift
//  SWAPI
//
//  Created by Michael Williams on 4/17/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import Foundation
import Freddy
import Deferred

class PlanetStore {
    private(set) var planets = [Planet]()
    private var client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    private func addPlanets(_ planets: [Planet]) {
        for planet in planets {
            add(planet)
        }
    }
    
    func getPlanets() -> Task<[Planet]> {
        let deferred = Deferred<TaskResult<[Planet]>>()
        
        let urlSessionTask = client.get(.planets) { (data, response, error) in
            guard let data = data else {
                deferred.fail(with: HTTPClient.Error.noData)
                return
            }
            do {
                let json = try JSON(data: data)
                let planets = try json.decodedArray(at: "results", type: Planet.self)
                self.addPlanets(planets)
                deferred.succeed(with: planets)
            } catch {
                deferred.fail(with: error)
            }
        }
        return Task(deferred, cancellation: {
            print("Cancelling `getPlanets()`.")
            urlSessionTask.cancel()
        })

    }
    
    private func add(_ planet:Planet) {
        guard !planets.contains(planet) else { return }
        planets.append(planet)
    }
    
    func cachedPlanet(for person:Person) -> Planet? {
        return planets.filter({$0.url == person.homeWorldURL}).first
    }
    
    func fetchPlanet(for person: Person) -> Deferred<Task<Planet>.Result> {
        let deferred = Deferred<Task<Planet>.Result>()
        if let planet = cachedPlanet(for: person) {
            deferred.succeed(with: planet)
            return deferred
        }
        
        client.fetchHomeWorld(for: person) { (data, response, error) in
            guard let data = data else {
                deferred.fail(with: HTTPClient.Error.noData)
                return
            }
            do {
                let json = try JSON(data: data)
                let planet = try Planet(json: json)
                self.add(planet)
                deferred.succeed(with: planet)
            } catch {
                deferred.fail(with: error)
            }
        }
        return deferred
    }

    func fetchPlanets(for people: [Person]) -> Task<Void> {
        let uniquePeople = peopleWithUniqueHomeWorlds(from: people)
        let deferredPlanets = uniquePeople.map { fetchPlanet(for: $0) }
        return deferredPlanets.allSucceeded()
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

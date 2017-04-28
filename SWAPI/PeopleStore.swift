//
//  PeopleStore.swift
//  SWAPI
//
//  Created by Michael Williams on 4/13/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import Foundation
import Deferred
import Freddy

class PeopleStore {
    private(set) var people = [Person]()
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    private func add(_ person: Person) {
        guard !people.contains(person) else { return }
        people.append(person)
    }
    
    private func addPeople(_ people: [Person]) {
        for person in people {
            add(person)
        }
    }
    
    func getPeople() -> Task<[Person]> {
        let deferred = Deferred<Task<[Person]>.Result>()
        let urlSessionTask = client.get(.people) { (data, response, error) in
            guard let data = data else {
                deferred.fail(with: HTTPClient.Error.noData)
                return
            }
            
            do {
                let json = try JSON(data:data)
                let people = try json.decodedArray(at: "results", type: Person.self)
                self.addPeople(people)
                deferred.succeed(with: people)
            } catch {
                deferred.fail(with: error)
            }
        }
        return Task(deferred, cancellation: {
            print("Cancelling `getPeople()`.")
            urlSessionTask.cancel()
        })
    }
}

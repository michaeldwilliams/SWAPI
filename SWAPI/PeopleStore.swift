//
//  PeopleStore.swift
//  SWAPI
//
//  Created by Michael Williams on 4/13/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import Foundation
import Freddy

class PeopleStore {
    private(set) var people = [Person]()
    private let client = HTTPClient()
    
    private func add(_ person: Person) {
        guard !people.contains(person) else { return }
        people.append(person)
    }
    
    private func addPeople(_ people: [Person]) {
        for person in people {
            add(person)
        }
    }
    
    func getPeople(completion: @escaping ([Person], Error?) -> Void) {
        client.get(.people) { (data, response, error) in
            guard let data = data else {
                completion([], HTTPClient.Error.noData)
                return
            }
            
            do {
                let json = try JSON(data:data)
                let people = try json.decodedArray(at: "results", type: Person.self)
                self.addPeople(people)
                completion(people, nil)
            } catch {
                completion([], error)
            }
        }
    }
}

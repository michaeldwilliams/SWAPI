//
//  HTTPClient.swift
//  SWAPI
//
//  Created by Michael Williams on 4/12/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import Foundation
struct HTTPClient {
    let session: MockURLSession
    
    init(session:MockURLSession = URLSession.shared) {
        self.session = session
    }
    
    func get(_ route:Route, completion: @escaping (Data?, URLResponse?, Swift.Error?) -> Void) {
        guard let url = URL(string: route.rawValue) else { return }
        let task = session.dataTask(with: url, completionHandler: completion)
        task.resume()
    }
    
    func fetchHomeWorld(for person:Person, completion: @escaping (Data?, URLResponse?, Swift.Error?) -> Void) {
        let task = session.dataTask(with: person.homeWorldURL, completionHandler: completion)
        task.resume()
    }
}

extension HTTPClient {
    enum Route:String {
        case base = "http://swapi.co/api/"
        case films = "http://swapi.co/api/films"
        case people = "http://swapi.co/api/people/"
        case planets = "http://swapi.co/api/planets/"
        case species = "http://swapi.co/api/species/"
        case starships = "http://swapi.co/api/starships/"
        case vehicles = "http://swapi.co/api/vehicles/"
    }
}

extension HTTPClient {
    
    enum Error: Swift.Error {
        case noData
        case couldNotMakeJSON
        case badURLString(String)
    }
}

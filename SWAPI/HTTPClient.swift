//
//  HTTPClient.swift
//  SWAPI
//
//  Created by Michael Williams on 4/12/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import Foundation
struct HTTPClient {
    private let session: MockURLSession
    
    init(session:MockURLSession = URLSession.shared) {
        self.session = session
    }
    
    @discardableResult
    func get(_ route:Route, completion: @escaping (Data?, URLResponse?, Swift.Error?) -> Void) -> MockURLSessionDataTask {
        guard let url = URL(string: route.rawValue) else {
            fatalError("Failed to unwrap \(route)")
        }
        let task = session.dataTask(with: url, completionHandler: completion)
        task.resume()
        return task
    }
    
    @discardableResult
    func fetchHomeWorld(for person:Person, completion: @escaping (Data?, URLResponse?, Swift.Error?) -> Void) -> MockURLSessionDataTask {
        let task = session.dataTask(with: person.homeWorldURL, completionHandler: completion)
        task.resume()
        return task
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

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
    
    func get(_ route:Route, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let url = URL(string: route.rawValue) else { return }
        let task = session.dataTask(with: url, completionHandler: completion)
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

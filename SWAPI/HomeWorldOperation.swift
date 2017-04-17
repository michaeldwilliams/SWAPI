//
//  HomeWorldOperation.swift
//  SWAPI
//
//  Created by Michael Williams on 4/17/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import Foundation
import Freddy

class HomeWorldOperation: Operation {

    private let planetStore: PlanetStore
    private let peopleStore: PeopleStore
    let completion: ([Planet], [Swift.Error]) -> Void
    override var isAsynchronous: Bool { return true }
    
    private var _isExecuting = false
    override var isExecuting: Bool {
        get {
            return _isExecuting
        }
        set {
            willChangeValue(forKey: "isExecuting")
            _isExecuting = newValue
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    private var _isFinished = false
    override var isFinished: Bool {
        get {
            return _isFinished
        }
        set {
            willChangeValue(forKey: "isFinished")
            _isFinished = newValue
            didChangeValue(forKey: "isFinished")
        }
    }
    
    init(peopleStore:PeopleStore, planetStore:PlanetStore, completion: @escaping ([Planet], [Error]) -> Void) {
        self.peopleStore = peopleStore
        self.planetStore = planetStore
        self.completion = completion
        super.init()
    }
    
    override func start() {
        isFinished = false
        isExecuting = true
        
        planetStore.fetchPlanets(for: peopleStore.people) { (planets, errors) in
            self.isExecuting = false
            self.isFinished = true
            self.completion(planets, errors)
        }
    }
    
}

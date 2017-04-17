//
//  PeopleOperation.swift
//  SWAPI
//
//  Created by Michael Williams on 4/17/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import Foundation
import Freddy

class PeopleOperation: Operation {

    private let peopleStore: PeopleStore
    private let completion: ([Person]?, Error?) -> Void
    
    init(peopleStore: PeopleStore, completion: @escaping ([Person]?, Error?) -> Void) {
        self.peopleStore = peopleStore
        self.completion = completion
    }
    
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
    
    private var _isFinished  = false
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
    
    override func start() {
        isExecuting = true
        isFinished = false
        
        peopleStore.getPeople { (people, error) in
            self.isExecuting = false
            self.isFinished = true
            self.completion(people, error)
        }
    }
    
}

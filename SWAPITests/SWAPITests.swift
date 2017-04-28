//
//  SWAPITests.swift
//  SWAPITests
//
//  Created by Michael Williams on 4/12/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import XCTest
import Freddy
@testable import SWAPI

class SWAPITests: XCTestCase {

    static let testBundle = Bundle(for: SWAPITests.self)
    fileprivate var mockSession: MockSession!
    
    let peopleURL = testBundle.url(forResource: "people", withExtension: "json")!
    let planetURL = testBundle.url(forResource: "homeWorld", withExtension: "json")!
    
    func JSONData(from url:URL) -> Data! {
        do {
            return try Data(contentsOf: url)
        } catch {
            XCTFail("Failed to create JSON data")
            return nil
        }
    }
    
    var client: HTTPClient!
    
    override func setUp() {
        super.setUp()
     
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testThatClientCanGETPeople() {
        guard let expectedData = JSONData(from: peopleURL) else {
            XCTFail("Didn't get people data")
            return
        }
        var receivedData:Data!
        mockSession = MockSession(data: expectedData)
        client = HTTPClient(session: mockSession)
        
        client.get(.people) { (data, _, _) in
            receivedData = data
        }
        
        XCTAssertEqual(receivedData, expectedData, "The `Data` should match.")
    
    }
    
    func testThatGETCanMakePeopleFromData() {
        guard let stubbedData = JSONData(from: peopleURL) else {
            XCTFail("Didn't get people data")
            return
        }
        
        var people = [Person]()
        
        mockSession = MockSession(data: stubbedData)
        client = HTTPClient(session: mockSession)
        
        client.get(.people) { (data, _, _) in
            guard let data = data else {
                XCTFail("No data to make `people`")
                return
            }
            
            do {
                let json = try JSON(data:data)
                people = try json.getArray(at: "results").map(Person.init(json:))
            } catch {
                XCTFail("Could not create `json` from `data`.")
                
            }
            
        }
        
        XCTAssertFalse(people.isEmpty, "`people` should not be empty")
    }
 
    func testThatClientCanGetHomeworld() {
        guard let stubbedPlanetData = JSONData(from: planetURL) else {
            XCTFail("Didn't get planet data")
            return
        }
        
        var expectPlanet: Planet!
        
        do {
            let expectJSON = try JSON(data: stubbedPlanetData)
            expectPlanet = try Planet(json: expectJSON)
        } catch {
            XCTFail("Couldn't get JSON")
        }
        
        mockSession = MockSession(data: stubbedPlanetData)
        client = HTTPClient(session: mockSession)
        
        let luke = Person(name: "Luke Skywalker",
                          height: 172,
                          mass: 77,
                          hairColor: "blond",
                          skinColor: "fair", 
                          eyeColor: "blue",
                          birthYear: "19BBY",
                          gender: "male",
                          homeWorldURL: URL(string: "http://swapi.co/api/planets/1/")!,
                          filmURLs: [],
                          speciesURL: [],
                          vehiclesURLs: [],
                          starShipsURLs: [],
                          url: URL(string: "http://swapi.co/api/people/1/")!
                          )
        
        client.fetchHomeWorld(for: luke) { (planetData, _, _) in
            guard let planetData = planetData else {
                XCTFail("No data to make planet.")
                return
            }
            do {
                let tatooineJSON = try JSON(data: planetData)
                let tatooine = try Planet(json: tatooineJSON)
                XCTAssertEqual(expectPlanet, tatooine, "The expected planet should be Tatooine")
            } catch {
                XCTFail("Failed to make planet JSON.")
            }
        }
        
    }
    
    
}

fileprivate class MockSession: MockURLSession {
    
    let dataTask = MockDataTask()
    let data: Data

    init(data:Data) {
        self.data = data
    }
    
    fileprivate func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> MockURLSessionDataTask {
        completionHandler(data, nil, nil)
        return dataTask
    }

}

fileprivate class MockDataTask: MockURLSessionDataTask {
    func resume() {}
    func cancel() {}
}

//
//  SWAPITests.swift
//  SWAPITests
//
//  Created by Michael Williams on 4/12/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import XCTest
@testable import SWAPI

class SWAPITests: XCTestCase {

    static let testBundle = Bundle(for: SWAPITests.self)
    fileprivate var mockSession: MockSession!
    
    let peopleURL = testBundle.url(forResource: "people", withExtension: "json")!
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
        
        var people = [Person?]()
        
        mockSession = MockSession(data: stubbedData)
        client = HTTPClient(session: mockSession)
        
        client.get(.people) { (data, _, _) in
            guard let data = data else {
                XCTFail("No data to make `people`")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                guard let jsonDictionary = json as? [String: Any] else {
                    XCTFail("Could not cast `data` to dictionary.")
                    return
                }
                
                guard let results = jsonDictionary["results"] as? [[String:Any]] else {
                    XCTFail("No `results` or could not cast to array of dictionaries.")
                   return
                }
                
                people = results.map(Person.from(json:))
            } catch {
                XCTFail("Could not create `json` from `data`.")
                
            }
            
        }
        
        XCTAssertFalse(people.isEmpty, "`people` should not be empty")
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
}

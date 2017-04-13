//
//  MockURLSession.swift
//  SWAPI
//
//  Created by Michael Williams on 4/12/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import Foundation

protocol MockURLSession {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> MockURLSessionDataTask
}

extension URLSession: MockURLSession {
    func dataTask(with url:URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> MockURLSessionDataTask {
        return dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTask as MockURLSessionDataTask
    }
}

//
//  MockURLSessionDataTask.swift
//  SWAPI
//
//  Created by Michael Williams on 4/12/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import Foundation

protocol MockURLSessionDataTask {
    func resume()
    func cancel()
}

extension URLSessionDataTask: MockURLSessionDataTask {}

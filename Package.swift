//
//  Package.swift
//  SWAPI
//
//  Created by Michael Williams on 4/13/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "SWAPI",
    targets: [],
    dependencies: [
        .Package(url: "git@github.com:bignerdranch/Freddy.git", majorVersion: 3)
    ],
    exclude: [
        "SWAPITests",
        "SWAPIUITests"
    ]
)

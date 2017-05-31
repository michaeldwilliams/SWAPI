//
//  PlanetDetailViewController.swift
//  SWAPI
//
//  Created by Michael Williams on 4/28/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import UIKit

class PlanetDetailViewController: UITableViewController {
    
    private var planet: Planet!
    fileprivate var rows: [AnyTableViewRow] = []
    
    
    func configure(planet: Planet) {
        self.planet = planet
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        rows.append(AnyTableViewRow(TwoLabelRow(title: "Name:", content: planet.name)))
        rows.append(AnyTableViewRow(TwoLabelRow(title: "Climate:", content: planet.climate)))
        rows.append(AnyTableViewRow(ThreeLabelRow(title: "Diameter:",
                                                  content: "\(planet.diameter)",
            units: "Km")))
        rows.append(AnyTableViewRow(TwoLabelRow(title: "Terrain:", content: planet.terrain)))
        let populationCount: String
        let populationUnits: String
        if planet.population == 0 {
            populationCount = "Unknown"
            populationUnits = ""
        } else if planet.population == 1 {
            populationCount = "1"
            populationUnits = "lifeform"
        } else {
            populationCount = "\(planet.population)"
            populationUnits = "lifeforms"
        }
        rows.append(AnyTableViewRow(ThreeLabelRow(title: "Population:",
                                                  content: populationCount,
                                                  units: populationUnits)))
        tableView.registerRow(type: TwoLabelRow.self)
        tableView.registerRow(type: ThreeLabelRow.self)
        
    }
}

extension PlanetDetailViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = rows[indexPath.row]
        return row.dequeueAndConfigureCell(tableView: tableView, indexPath: indexPath)
    }
}

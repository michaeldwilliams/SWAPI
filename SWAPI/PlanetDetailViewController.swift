//
//  PlanetDetailViewController.swift
//  SWAPI
//
//  Created by Michael Williams on 4/28/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import UIKit

class PlanetDetailViewController: UIViewController {
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var climateLabel: UILabel!
    @IBOutlet private var diameterLabel: UILabel!
    @IBOutlet private var terrainLabel: UILabel!
    @IBOutlet private var populationLabel: UILabel!
    
    
    private var planet: Planet!
    
    func configure(planet: Planet) {
        self.planet = planet
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameLabel.text = planet.name
        climateLabel.text = planet.climate
        diameterLabel.text = "\(planet.diameter) Km"
        terrainLabel.text = planet.terrain
        var populationString: String
        if planet.population == 0 {
            populationString = "Unknown"
        } else if planet.population == 1 {
            populationString = "1 lifeform"
        } else {
            populationString = "\(planet.population) lifeforms"
        }
        populationLabel.text = populationString
        
    }
}

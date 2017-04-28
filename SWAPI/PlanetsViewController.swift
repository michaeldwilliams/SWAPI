//
//  PlanetsViewController.swift
//  SWAPI
//
//  Created by Michael Williams on 4/28/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import UIKit
import Deferred

class PlanetsViewController: UITableViewController, AlertPresenter {

    fileprivate let cellID = "UITableViewCell"
    fileprivate var planetStore: PlanetStore!
    private var futurePlanets: Task<[Planet]>?
    
    func configure(planetStore: PlanetStore) {
        self.planetStore = planetStore
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        futurePlanets = planetStore.getPlanets()
        
        futurePlanets?.upon(.main) { (result) in
            switch result {
            case .success:
                self.tableView.reloadData()
            case .failure(let error):
                self.present(title: "Error getting planets", error: error)
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        futurePlanets?.cancel()
    }
    
}


extension PlanetsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planetStore.planets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let planet = planetStore.planets[indexPath.row]
        cell.textLabel?.text = planet.name
        var populationString: String
        if planet.population == 0 {
            populationString = "Population: unknown"
        } else if planet.population == 1 {
            populationString = "Population: 1 lifeform"
        } else {
            populationString = "Population: \(planet.population) lifeforms"
        }
        cell.detailTextLabel?.text = populationString
        return cell
    }
}

extension PlanetsViewController {
    enum ViewControllerSegue: String {
        case showPlanetDetails
    }
}

extension PlanetsViewController: SegueHandler {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifierCase(for: segue) {
        case .showPlanetDetails:
            guard let indexPath = tableView.indexPathForSelectedRow else {
                assertionFailure("showPlanetDetails segue triggered with no selected index path")
                return }
            let destination = segue.destination as! PlanetDetailViewController
            destination.configure(planet: planetStore.planets[indexPath.row])
        }
    }
}

//
//  RootViewController.swift
//  SWAPI
//
//  Created by Michael Williams on 4/28/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    private let httpClient = HTTPClient()
    fileprivate let peopleStore: PeopleStore
    fileprivate let planetStore: PlanetStore
    
    required init?(coder aDecoder: NSCoder) {
        peopleStore = PeopleStore(client: httpClient)
        planetStore = PlanetStore(client: httpClient)
        super.init(coder: aDecoder)
    }
    
    
}

extension RootViewController {
    enum ViewControllerSegue: String {
        case showPeople
        case showPlanets
    }
}

extension RootViewController: SegueHandler {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifierCase(for: segue) {
        case .showPeople:
            let destination = segue.destination as! PeopleViewController
            destination.configure(peopleStore: peopleStore, planetStore: planetStore)
        case .showPlanets:
            let destination = segue.destination as! PlanetsViewController
            destination.configure(planetStore: planetStore)
        }
    }

}

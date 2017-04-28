//
//  PeopleViewController.swift
//  SWAPI
//
//  Created by Michael Williams on 4/12/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//


import UIKit
import Deferred

class PeopleViewController: UITableViewController, AlertPresenter {

    let cellID = "UITableViewCell"
    fileprivate var peopleStore: PeopleStore!
    fileprivate var planetStore: PlanetStore!
    var futurePeople: Task<[Person]>? = nil
    
    func configure(peopleStore:PeopleStore, planetStore:PlanetStore) {
        self.peopleStore = peopleStore
        self.planetStore = planetStore
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        futurePeople = peopleStore.getPeople()
        
        let futurePlanets = futurePeople?.andThen(upon: .any()) { (people) -> Task<Void> in
            return self.planetStore.fetchPlanets(for: people)
        }
        
        futurePlanets?.upon(.main) { (result) in
            switch result {
            case .success:
                self.tableView.reloadData()
            case .failure(let error):
                self.present(title: "Error getting people", error: error)
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        futurePeople?.cancel()
    }
}



extension PeopleViewController {
    
//MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleStore.people.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let person = peopleStore.people[indexPath.row]
        let homeWorld = planetStore.cachedPlanet(for: person)
        cell.textLabel?.text = person.name
        cell.detailTextLabel?.text = homeWorld?.name
        return cell
    }
    
}

extension PeopleViewController {
    enum ViewControllerSegue: String {
        case showPersonDetails
    }
}

extension PeopleViewController: SegueHandler {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifierCase(for: segue) {
        case .showPersonDetails:
            guard let indexPath = tableView.indexPathForSelectedRow else {
                assertionFailure("showPersonDetails segue triggered with no selected index path")
                return }
            let person = peopleStore.people[indexPath.row]
            let homeworld = planetStore.cachedPlanet(for: person)
            let destination = segue.destination as! PersonDetailViewController
            destination.configure(person: person, homeWorldName: homeworld?.name)
        }
    }
}


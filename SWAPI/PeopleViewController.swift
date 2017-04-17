//
//  PeopleViewController.swift
//  SWAPI
//
//  Created by Michael Williams on 4/12/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//


import Foundation
import UIKit

class PeopleViewController: UITableViewController {

    let cellID = "UITableViewCell"
    let peopleStore = PeopleStore()
    let planetStore = PlanetStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let queue = OperationQueue()
        let peopleOperation = PeopleOperation(peopleStore: peopleStore) { (people, error) in
            if let error = error {
                self.present(error: error)
                return
            }
            
            guard people != nil else { return }
            
        }
        
        let homeWorldOperation = HomeWorldOperation(peopleStore: peopleStore, planetStore: planetStore) { (planets, errors) in
            guard errors.isEmpty else {
                errors.forEach { self.present(error: $0) }
                return
            }
        }
        
        homeWorldOperation.addDependency(peopleOperation)
        
        let completionOperation = BlockOperation {
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
        }
        completionOperation.addDependency(homeWorldOperation)
        
        queue.addOperations([peopleOperation, homeWorldOperation, completionOperation], waitUntilFinished: false)
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
    
//MARK: - Present Error Alerts to UI
    func present(error: Swift.Error) {
        let alertController = UIAlertController(title: "Error getting people", message: "\(error)", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        OperationQueue.main.addOperation {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
}

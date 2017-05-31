//
//  PersonDetailViewController.swift
//  SWAPI
//
//  Created by Michael Williams on 4/28/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import UIKit

class PersonDetailViewController: UITableViewController {
    

    private var person: Person!
    private var homeWorldName: String?
    fileprivate var rows: [AnyTableViewRow] = []
    
    func configure(person: Person, homeWorldName: String?) {
        self.person = person
        self.homeWorldName = homeWorldName
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        rows.append(AnyTableViewRow(TwoLabelRow(title: "Name:", content: person.name)))
        rows.append(AnyTableViewRow(ThreeLabelRow(title: "Height:", content: "\(person.height)", units: "cm")))
        rows.append(AnyTableViewRow(ThreeLabelRow(title: "Mass:",
                                                  content: "\(person.mass)",
            units: "Kg")))
        rows.append(AnyTableViewRow(TwoLabelRow(title: "Hair color:",
                                                content: person.hairColor)))
        rows.append(AnyTableViewRow(TwoLabelRow(title: "Skin color:",
                                                content: person.skinColor)))
        rows.append(AnyTableViewRow(TwoLabelRow(title: "Eye color:", content: person.eyeColor)))
        rows.append(AnyTableViewRow(TwoLabelRow(title: "Birth year:",
                                                content: person.birthYear)))
        rows.append(AnyTableViewRow(TwoLabelRow(title: "Gender:", content: person.gender)))
        if let homeworldName = homeWorldName {
            rows.append(AnyTableViewRow(TwoLabelRow(title: "Homeworld:",
                                                    content: homeworldName)))
        }
        tableView.registerRow(type: TwoLabelRow.self)
        tableView.registerRow(type: ThreeLabelRow.self)

    }
}

extension PersonDetailViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = rows[indexPath.row]
        return row.dequeueAndConfigureCell(tableView: tableView, indexPath: indexPath)
    }
}

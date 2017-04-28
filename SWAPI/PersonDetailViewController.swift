//
//  PersonDetailViewController.swift
//  SWAPI
//
//  Created by Michael Williams on 4/28/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import UIKit

class PersonDetailViewController: UIViewController {
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var heightLabel: UILabel!
    @IBOutlet private var massLabel: UILabel!
    @IBOutlet private var hairColorLabel: UILabel!
    @IBOutlet private var skinColorLabel: UILabel!
    @IBOutlet private var eyeColorLabel: UILabel!
    @IBOutlet private var birthYearLabel: UILabel!
    @IBOutlet private var genderLabel: UILabel!
    @IBOutlet private var homeWorldLabel: UILabel!
    
    private var person: Person!
    private var homeWorldName: String?
    
    func configure(person: Person, homeWorldName: String?) {
        self.person = person
        self.homeWorldName = homeWorldName
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameLabel.text = person.name
        heightLabel.text = "\(person.height) cm"
        massLabel.text = "\(person.mass) Kg"
        hairColorLabel.text = person.hairColor
        skinColorLabel.text = person.skinColor
        eyeColorLabel.text = person.eyeColor
        birthYearLabel.text = person.birthYear
        genderLabel.text = person.gender
        homeWorldLabel.text = homeWorldName
    }
}

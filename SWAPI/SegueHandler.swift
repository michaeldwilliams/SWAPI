//
//  SegueHandler.swift
//  SWAPI
//
//  Created by Michael Williams on 4/28/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import UIKit

protocol SegueHandler {
    associatedtype ViewControllerSegue: RawRepresentable
    func segueIdentifierCase(for segue: UIStoryboardSegue) -> ViewControllerSegue
}

extension SegueHandler where Self: UIViewController, ViewControllerSegue.RawValue == String {
    
    func segueIdentifierCase(for segue: UIStoryboardSegue) -> ViewControllerSegue {
        guard let identifier = segue.identifier else {
            fatalError("Missing segue identifier")
        }
        guard let identifierCase = ViewControllerSegue(rawValue: identifier) else {
            fatalError("Could not map segue identifier -- \(identifier) -- to segue case")
        }
        return identifierCase
    }
}

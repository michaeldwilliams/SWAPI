//
//  ThreeLabelRow.swift
//  SWAPI
//
//  Created by Michael Williams on 5/1/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import Foundation
import UIKit

class ThreeLabelRow: TableViewRow {
    typealias Cell = ThreeLabelTableViewCell
    static let cellIdentifier = "ThreeLabelTableViewCell"
    private let title: String
    private let content: String
    private let units: String
    
    init(title: String, content: String, units: String) {
        self.title = title
        self.content = content
        self.units = units
    }
    
    func configure(cell: ThreeLabelTableViewCell) {
        cell.titleLabel.text = title
        cell.contentLabel.text = content
        cell.unitsLabel.text = units
    }
}

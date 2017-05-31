//
//  TwoLabelRow.swift
//  SWAPI
//
//  Created by Michael Williams on 5/1/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import Foundation
import UIKit

class TwoLabelRow: TableViewRow {
    typealias Cell = TwoLabelTableViewCell
    static let cellIdentifier = "TwoLabelTableViewCell"
    private let title: String
    private let content: String
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
    }
    
    func configure(cell: TwoLabelTableViewCell) {
        cell.titleLabel.text = title
        cell.contentLabel.text = content
    }
}

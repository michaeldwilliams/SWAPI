//
//  TableViewRow.swift
//  SWAPI
//
//  Created by Michael Williams on 5/1/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import Foundation
import UIKit

protocol TableViewRow: class {
    associatedtype Cell: UITableViewCell
    
    static var cellIdentifier: String { get }
    func configure(cell: Cell)
}

extension UITableView {
    func registerRow<Row: TableViewRow>(type _: Row.Type) where Row.Cell: NibLoadable {
        register(Row.Cell.nib, forCellReuseIdentifier: Row.cellIdentifier)
    }
}

//
//  ExistentialTableViewRow.swift
//  SWAPI
//
//  Created by Michael Williams on 5/1/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import Foundation
import UIKit

private class AnyTableViewRowBoxBase {
    let cellIdentifier: String
    
    init(cellIdentifier:String) {
        self.cellIdentifier = cellIdentifier
    }
    
    func dequeueAndConfigureCell(tableView:UITableView, indexPath: IndexPath) -> UITableViewCell {
        fatalError("Subclasses must override this method")
    }
}


private class AnyTableViewRowBox<Row: TableViewRow>: AnyTableViewRowBoxBase {
    let row: Row
    init(_ row: Row) {
        self.row = row
        super.init(cellIdentifier: Row.cellIdentifier)
    }
    
    override func dequeueAndConfigureCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Row.cellIdentifier, for: indexPath) as! Row.Cell
        
        row.configure(cell: cell)
        return cell
    }
}

final class AnyTableViewRow {
    private let row: AnyTableViewRowBoxBase
    
    private var cellIdentifier: String {
        return row.cellIdentifier
    }
    
    init<Row: TableViewRow>(_ row: Row) {
        self.row = AnyTableViewRowBox(row)
    }
    
    func dequeueAndConfigureCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        return row.dequeueAndConfigureCell(tableView: tableView, indexPath: indexPath)
    }
}

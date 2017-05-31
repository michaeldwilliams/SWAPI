//
//  ThreeLabelTableViewCell.swift
//  SWAPI
//
//  Created by Michael Williams on 5/1/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import UIKit

class ThreeLabelTableViewCell: UITableViewCell {

    @IBOutlet private(set) var titleLabel: UILabel!
    @IBOutlet private(set) var contentLabel: UILabel!
    @IBOutlet private(set) var unitsLabel: UILabel!
}

extension ThreeLabelTableViewCell: NibLoadable {
    static var nibName: String {
        return "ThreeLabelTableViewCell"
    }
}

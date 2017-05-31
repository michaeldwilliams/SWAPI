//
//  TwoLabelTableViewCell.swift
//  SWAPI
//
//  Created by Michael Williams on 5/1/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import UIKit

class TwoLabelTableViewCell: UITableViewCell {

    @IBOutlet private(set) var titleLabel: UILabel!
    @IBOutlet private(set) var contentLabel: UILabel!
    
}

extension TwoLabelTableViewCell: NibLoadable {
    static var nibName: String {
        return "TwoLabelTableViewCell"
    }
}


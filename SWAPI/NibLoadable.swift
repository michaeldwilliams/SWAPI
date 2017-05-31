//
//  NibLoadable.swift
//  SWAPI
//
//  Created by Michael Williams on 5/1/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import Foundation
import UIKit

protocol NibLoadable: class {
    static var nibName: String { get }
    static var nib: UINib { get }
}

extension NibLoadable {
    static var nib: UINib {
        return UINib(nibName: nibName, bundle: Bundle(for: self))
    }
}


//
//  AlertPresenter.swift
//  SWAPI
//
//  Created by Michael Williams on 4/28/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import UIKit

protocol AlertPresenter {
    func present(title:String, error: Swift.Error)
}

extension AlertPresenter where Self:UIViewController {
    func present(title: String, error: Swift.Error) {
        let alertController = UIAlertController(title: title, message: "\(error)", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        OperationQueue.main.addOperation {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

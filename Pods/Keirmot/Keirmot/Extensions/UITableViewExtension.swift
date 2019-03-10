//
//  UITableViewExtension.swift
//  aCultural
//
//  Created by Joao Pires on 11/30/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import UIKit

extension UITableView {
    
    /// Register UITableViewCell
    ///
    /// - Parameter cellName: cellName should be the same for Identifier and XIB Name
    open func registerForCell(_ cellName: String) {
        
        let cell = UINib(nibName: cellName, bundle: nil)
        self.register(cell, forCellReuseIdentifier: cellName)
    }
    
}

//
//  UITableViewExtension.swift
//  aCultural
//
//  Created by Joao Pires on 11/30/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import UIKit

extension UITableView {
    
    func registerForCell(_ cellName: String) {
        
        let cell = UINib(nibName: cellName, bundle: nil)
        self.register(cell, forCellReuseIdentifier: cellName)
    }
    
}

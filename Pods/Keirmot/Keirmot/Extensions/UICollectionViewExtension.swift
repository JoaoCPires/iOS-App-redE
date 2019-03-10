//
//  UICollectionViewExtension.swift
//  redE
//
//  Created by Joao Pires on 12/21/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    /// Register UICollectionViewCell
    ///
    /// - Parameter cellName: cellName should be the same for Identifier and XIB Name
    open func registerForCell(_ cellName: String) {
        
        let cell = UINib(nibName: cellName, bundle: nil)
        self.register(cell, forCellWithReuseIdentifier: cellName)
    }
    
}

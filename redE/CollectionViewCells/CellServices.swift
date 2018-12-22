//
//  CellServices.swift
//  redE
//
//  Created by Joao Pires on 12/21/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import UIKit

class CellServices: UICollectionViewCell {
    @IBOutlet weak var viewIconContainer: UIView!
    @IBOutlet weak var imageService: UIImageView!
    
    static let identifier = "CellServices"
    
    var service: Service!
    
    func setup(withService sentService: Service) {
        
        self.service = sentService
        self.imageService.image = sentService.image
        self.viewIconContainer.layer.cornerRadius = self.viewIconContainer.frame.width / 2
    }
    
}

//
//  ContactCollectionViewCell.swift
//  redE
//
//  Created by Joao Pires on 16/01/2020.
//  Copyright © 2020 Joao Pires. All rights reserved.
//

import UIKit
import KeirmotUtils

class ContactCollectionViewCell: UICollectionViewCell, CollectionCellPrototype {
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var viewIconContainer: UIView!
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelNumber: UILabel!
    
    static var identifier = "ContactCollectionViewCell"
    var contact: Contact!
    
    func setup(with data: Any?) {
        
        if let contactData = data as? Contact {
            
            contact = contactData
            setupContainer()
            setupImage()
            setupLabels()
        }
    }
    
    private func setupContainer() {
        
        viewContainer.layer.cornerRadius = 10
        viewContainer.layer.masksToBounds = false
        viewContainer.layer.shadowColor = UIColor.black.cgColor
        viewContainer.layer.shadowOpacity = 0.2
        viewContainer.layer.shadowOffset = CGSize(width: -1, height: 1)
        viewContainer.layer.shadowRadius = 3
    }
    
    private func setupImage() {
        
        viewIconContainer.backgroundColor = .systemBlue
        viewIconContainer.layer.cornerRadius = viewIconContainer.frame.height / 2
        imageIcon.image = UIImage(named: contact.imageName)
        imageIcon.tintColor = .white
    }
    
    private func setupLabels() {
        
        labelName.text = contact.title
        labelNumber.text = contact.phoneNumber
    }
}

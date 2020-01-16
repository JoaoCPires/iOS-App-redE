//
//  ContactsTableViewCell.swift
//  redE
//
//  Created by Joao Pires on 15/01/2020.
//  Copyright © 2020 Joao Pires. All rights reserved.
//

import UIKit
import KeirmotUtils

class ContactsTableViewCell: UITableViewCell, TableCellPrototype {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var labelTitle: UILabel!
    
    static var identifier = "ContactsTableViewCell"
    
    private var station: BaseStation!

    func setup(with data: Any?) {
        
        if let stationData = data as? BaseStation {
            
            station = stationData
            setupCollectionView()
            labelTitle.text = "label.contacts".localized
        }

    }

    private func setupCollectionView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerForCell(ContactCollectionViewCell.identifier)
    }
}

extension ContactsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        station.contacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ContactCollectionViewCell.identifier,
            for: indexPath) as! ContactCollectionViewCell
        
        cell.setup(with: station.contacts[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width * 0.9
        let height = collectionView.frame.height * 0.9
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let contact = station.contacts[indexPath.item]
        let phoneNumber = contact.callingNumber
        if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            
                UIApplication.shared.open(url)
        }
    }
    
}

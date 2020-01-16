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
    
    static var identifier = "ContactsTableViewCell"
    
    private var station: BaseStation!

    func setup(with data: Any?) {
        
        if let stationData = data as? BaseStation {
            
            station = stationData
        }

    }

}

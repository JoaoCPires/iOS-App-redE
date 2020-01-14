//
//  TrainStationTableViewCell.swift
//  redE
//
//  Created by Joao Pires on 14/01/2020.
//  Copyright © 2020 Joao Pires. All rights reserved.
//

import UIKit
import KeirmotUtils

class TrainStationTableViewCell: UITableViewCell, TableCellPrototype {

    static let identifier = "TrainStationTableViewCell"

    var station: BaseStation!
    
    func setup(with data: Any?) {
        
        if let stationData = data as? BaseStation {
            
            station = stationData
        }
    }
}

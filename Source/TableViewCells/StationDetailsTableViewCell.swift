//
//  StationDetailsTableViewCell.swift
//  redE
//
//  Created by Joao Pires on 15/01/2020.
//  Copyright © 2020 Joao Pires. All rights reserved.
//

import UIKit
import KeirmotUtils

class StationDetailsTableViewCell: UITableViewCell, TableCellPrototype {
    @IBOutlet weak var labelStationName: UILabel!
    @IBOutlet weak var labelStationLine: UILabel!
    @IBOutlet weak var labelStationAddress: UILabel!
    @IBOutlet weak var stackOfAmeneties: UIStackView!
    
    static var identifier = "StationDetailsTableViewCell"
    
    private var station: BaseStation!
    
    func setup(with data: Any?) {
        
        if let stationData = data as? BaseStation {
            
            station = stationData
            setupLabels()
            setupAmeneties()
        }
    }
    
    private func setupLabels() {
        
        labelStationName.text = station.stationName
        labelStationLine.text = station.details.linha
        labelStationAddress.text = station.details.morada
    }
    
    private func setupAmeneties() {
        
        stackOfAmeneties.subviews.forEach({$0.removeFromSuperview()})
        station.ameneties.forEach({
            
            let view = UIView()
            view.heightAnchor.constraint(equalToConstant: 32).isActive = true
            view.widthAnchor.constraint(equalToConstant: 32).isActive = true
            view.backgroundColor = .systemBlue
            view.layer.cornerRadius = 32 / 2
            
            let icon = UIImage(named: $0.imageName)
            let imageView = UIImageView(image: icon)
            imageView.tintColor = .systemBackground
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
            
            view.translatesAutoresizingMaskIntoConstraints = true
            imageView.translatesAutoresizingMaskIntoConstraints = true
                        
            view.addSubview(imageView)
            imageView.center = CGPoint(x: 16, y: 16)

            stackOfAmeneties.addArrangedSubview(view)
        })
    }
}

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
    @IBOutlet weak var labelStationName: UILabel!
    @IBOutlet weak var stackOfAmeneties: UIStackView!
    @IBOutlet weak var viewContainer: UIView!
    
    static let identifier = "TrainStationTableViewCell"

    var station: BaseStation!
    
    func setup(with data: Any?) {
        
        if let stationData = data as? BaseStation {
            
            station = stationData
            setupLabels()
            setupAmeneties()
            setupContainerView()
        }
    }
    
    private func setupLabels() {
        
        labelStationName.text = station.stationName
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
            imageView.tintColor = .white
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
            
            view.translatesAutoresizingMaskIntoConstraints = true
            imageView.translatesAutoresizingMaskIntoConstraints = true
                        
            view.addSubview(imageView)
            imageView.center = CGPoint(x: 16, y: 16)

            stackOfAmeneties.addArrangedSubview(view)
        })
    }
    
    private func setupContainerView() {
        
        viewContainer.layer.cornerRadius = 10
        viewContainer.layer.masksToBounds = false
        viewContainer.layer.shadowColor = UIColor.label.cgColor
        viewContainer.layer.shadowOpacity = 0.2
        viewContainer.layer.shadowOffset = CGSize(width: -1, height: 1)
        viewContainer.layer.shadowRadius = 3
    }

}

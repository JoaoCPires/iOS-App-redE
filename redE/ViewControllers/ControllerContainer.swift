//
//  ControllerContainer.swift
//  redE
//
//  Created by Joao Pires on 12/20/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import UIKit
import Pulley

protocol StationDelegate {
    func didSelect(station: TrainStation)
}

class ControllerContainer: PulleyViewController {

    static let identifier = "ControllerContainer"
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        guard let main = self.primaryContentViewController as? ControllerStationMap else { return }
//        guard let secondary = self.drawerContentViewController as? ControllerTrainStation else { return }
        main.delegate = self
    }
}

extension ControllerContainer: StationDelegate {
    
    func didSelect(station: TrainStation) {
        
//        guard let main = self.primaryContentViewController as? ControllerStationMap else { return }
        guard let secondary = self.drawerContentViewController as? ControllerTrainStation else { return }
        secondary.didSelect(station: station)
    }

}

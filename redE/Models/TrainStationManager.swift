//
//  TrainStationManager.swift
//  redE
//
//  Created by Joao Pires on 12/20/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import UIKit

protocol TrainStationDelegate {
    func didReceive(stations: TrainStations)
    func didReceive(station: TrainStation)
}

class TrainStationManager {
    
    static let shared = TrainStationManager()
    
    var delegate: TrainStationDelegate?
    
    func setup() {
        
        if Cache.repository.trainStations.count == 0 {
            
            TrainStationsApiManager.shared.getAll { (allStations: TrainStations) in
                
                PersistencyManager.shared.save(trainStations: allStations)
            }
        }
    }
    
    func resquestStations() {
        
        let allStations = Cache.repository.trainStations
        delegate?.didReceive(stations: allStations)
        TrainStationsApiManager.shared.getAll { (allStations: TrainStations) in
            
            PersistencyManager.shared.save(trainStations: allStations)
            self.delegate?.didReceive(stations: allStations)
        }
    }
    
    func requestStation(withId sentID: String) {
        
        let allStations = Cache.repository.trainStations
        for station in allStations {
            
            if station.nodeID == sentID {
                
                self.delegate?.didReceive(station: station)
                break
            }
        }
    }
}

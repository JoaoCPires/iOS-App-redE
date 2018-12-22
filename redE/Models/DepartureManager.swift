//
//  DepartureManager.swift
//  redE
//
//  Created by Joao Pires on 12/20/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import UIKit

protocol DepartureDelegate {
    func didReceive(departure: Departures)
}

class DepartureManager {
    
    static let shared = DepartureManager()
    
    var delegate: DepartureDelegate?
    
    func setup() {
        
        if Cache.repository.trainStations.count == 0 {
            
            TrainStationsApiManager.shared.getAll { (allStations: TrainStations) in
                
                PersistencyManager.shared.save(trainStations: allStations)
            }
        }
    }
    
    func resquestDeparture(withId sentID: String) {
        
        let departures = Cache.repository.departures
        delegate?.didReceive(departure: departures)
        DepartureApiManager.shared.getAll(forStation: sentID) { (departures: Departures) in
            
            Cache.repository.set(departures: departures)
            self.delegate?.didReceive(departure: departures)
        }
    }
}

//
//  TrainStationManager.swift
//  redE
//
//  Created by Joao Pires on 12/20/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import UIKit

protocol TrainStationDelegate {
    func didReceive(allStations: TrainStations)
    func didReceive(filteredStations: TrainStations)
    func didReceive(station: TrainStation)
}

class TrainStationManager {
    
    static let shared = TrainStationManager()
    private var filter = String()
    
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
        delegate?.didReceive(allStations: allStations)
        TrainStationsApiManager.shared.getAll { (allStations: TrainStations) in
            
            PersistencyManager.shared.save(trainStations: allStations)
            self.delegate?.didReceive(allStations: allStations)
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
    
    func requestFilteredStations() {
        
        let allStations = Cache.repository.trainStations
        var filteredStations = TrainStations()
        for station in allStations {
            
            if station.linha! == filter {
                
                filteredStations.append(station)
            }
        }
        self.delegate?.didReceive(filteredStations: filteredStations)
        resquestStations()
    }
    
    func setNew(filter: String) {
        
        self.filter = filter
    }
    
    func getSetFilter() -> String {
        
        return filter
    }
}

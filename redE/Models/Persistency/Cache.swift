//
//  Cache.swift
//  redE
//
//  Created by Joao Pires on 12/20/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import UIKit

class Cache {
    
    static let repository = Cache()
    private (set) var trainStations = TrainStations()
    private (set) var departures = Departures()
    private (set) var stationTag = String()
    
    func set(trainStations: TrainStations) {
        
        self.trainStations = trainStations
    }
    
    func set(departures: Departures) {
        
        self.departures = departures
    }
    
    func set(stationTag:String) {
        
        self.stationTag = stationTag
    }
}

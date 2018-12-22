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
    
    func set(trainStations: TrainStations) {
        
        self.trainStations = trainStations
    }
    
    func set(departures: Departures) {
        
        self.departures = departures
    }
}

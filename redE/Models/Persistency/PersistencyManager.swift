//
//  PersistencyManager.swift
//  redE
//
//  Created by Joao Pires on 12/20/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import UIKit

class PersistencyManager {
    
    static let shared = PersistencyManager()
    private static let trainStationsKey = "redE-Train-Stations"
    
    func setup() {
        if let allStations = Storage.retrieve(PersistencyManager.trainStationsKey, from: Storage.Directory.caches, as: TrainStations.self) {
            
            Cache.repository.set(trainStations: allStations)
        }
    }
    
    func save(trainStations: TrainStations) {
        
        Storage.store(trainStations, to: Storage.Directory.caches, as: PersistencyManager.trainStationsKey)
        Cache.repository.set(trainStations: trainStations)
    }
}

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
    private let trainStationsKey = "redE-Train-Stations"
    private let trainStationTag = "redE-Train-Stations-Tag"

    func setup() {
        if let allStations = Storage.retrieve(trainStationsKey, from: Storage.Directory.caches, as: TrainStations.self) {

            Cache.repository.set(trainStations: allStations)
        }
        let defaults = UserDefaults.standard
        if let tag = defaults.value(forKey: trainStationTag) as? String {

            Cache.repository.set(stationTag: tag)
        }
    }

    func save(trainStations: TrainStations) {

        Storage.store(trainStations, to: Storage.Directory.caches, as: trainStationsKey)
        Cache.repository.set(trainStations: trainStations)
    }

    func save(newTag: String) {

        let defaults = UserDefaults.standard
        defaults.set(newTag, forKey: trainStationTag)
        Cache.repository.set(stationTag: newTag)
    }
}

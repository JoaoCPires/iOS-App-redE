//
//  EventBus.swift
//  aCultural
//
//  Created by Joao Pires on 12/6/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import UIKit

class EventBus: TrainStationDelegate, DepartureDelegate {

    static let global = EventBus()
    private var registry = EventResgistry()

    init() {

        TrainStationManager.shared.delegate = self
        DepartureManager.shared.delegate = self
    }

    func register(listener: EventBusListener, inRegistry appAction: AppAction) {

        guard var specificResgistry = registry[appAction.action!] else {
            registry.updateValue([listener], forKey: appAction.action!)
            return
        }
        specificResgistry.append(listener)
        registry.updateValue(specificResgistry, forKey: appAction.action!)
    }

    func unregister(listener: EventBusListener, inRegistry appAction: AppAction) {

        guard var specificRegistry = registry[appAction.action!] else { return }
        for index in 0..<specificRegistry.count {

            if specificRegistry[index].busIdentifier == listener.busIdentifier {

                specificRegistry.remove(at: index)
                break
            }
        }
        registry.updateValue(specificRegistry, forKey: appAction.action!)
    }

    func numberOfListeners(for appEvent: AppAction) -> Int {

        return self.registry[appEvent.action!]?.count ?? 0
    }

    // MARK: - Requests to Managers
    func runAction(for appAction: AppAction) {

        DispatchQueue.global().async {

            switch appAction.action! {
            case .none: break
            case .allTrainStations: TrainStationManager.shared.resquestStations()
            case .trainStation: TrainStationManager.shared.requestStation(withId: appAction.stringID!)
            case .departure: DepartureManager.shared.resquestDeparture(withId: appAction.stringID!)
                
            }
        }
    }

    // MARK: - Managers Response
    func handle<T>(appEvent: AppEvent<T>, forRegistry requestedRegistry: ActionType) {

        guard let specificRegistry = registry[requestedRegistry] else { return }
        for module in specificRegistry {

            DispatchQueue.main.async {

                module.didReceive(appEvent: appEvent)
            }
        }
    }
    
    // MARK: - TrainStation Delegate
    func didReceive(stations: TrainStations) {
        
        let newEvent = AppEvent(data: stations)
        handle(appEvent: newEvent, forRegistry: .allTrainStations)
    }
    
    func didReceive(station: TrainStation) {
        
        let newEvent = AppEvent(data: station)
        handle(appEvent: newEvent, forRegistry: .trainStation)
    }
    
    // MARK: - Departure Delegate
    func didReceive(departure: Departures) {
        
        let newEvent = AppEvent(data: departure)
        handle(appEvent: newEvent, forRegistry: .departure)
    }


}

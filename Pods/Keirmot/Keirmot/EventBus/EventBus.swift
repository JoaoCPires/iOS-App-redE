//
//  EventBus.swift
//  aCultural
//
//  Created by Joao Pires on 12/6/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import UIKit

public class EventBus {

    public static let global = EventBus()
    private var registry = EventResgistry()

    init() {

        delegation()
    }

    /// Override this method to register for managers delegates
    func delegation() {

    }

    public func register(listener: EventBusListener, busRequest request: BusRequest) {

        PerformanceTester.logTime(.start, description: "EventBus Register:")
        guard var specificResgistry = registry[request.action!] else {
            registry.updateValue([listener], forKey: request.action!)
            return
        }
        specificResgistry.append(listener)
        registry.updateValue(specificResgistry, forKey: request.action!)
    }

    public func unregister(listener: EventBusListener, busRequest request: BusRequest) {

        
        guard var specificRegistry = registry[request.action!] else { return }
        for index in 0..<specificRegistry.count {

            if specificRegistry[index].busIdentifier == listener.busIdentifier {

                specificRegistry.remove(at: index)
                break
            }
        }
        registry.updateValue(specificRegistry, forKey: request.action!)
    }

    public func numberOfListeners(for request: BusRequest) -> Int {

        return self.registry[request.action!]?.count ?? 0
    }

    // MARK: - Requests to Managers
    public func runAction(for busRequest: BusRequest) {

        DispatchQueue.global().async {

            _ = busRequest.request
        }
    }

    // MARK: - Managers Response
    public func handle<T>(reply: BusReply<T>, forRegistry requestedRegistry: String) {

        guard let specificRegistry = registry[requestedRegistry] else { return }
        for module in specificRegistry {

            DispatchQueue.main.async {

                module.didReceive(busReply: reply)
            }
        }
    }

}

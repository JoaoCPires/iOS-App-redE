//
//  EventBusListener.swift
//  aCultural
//
//  Created by Joao Pires on 12/13/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import UIKit

public protocol EventBusListener {
    var busIdentifier: String { get }
    func didReceive<T>(busReply: BusReply<T>)
}

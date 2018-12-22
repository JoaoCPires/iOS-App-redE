//
//  EventBusListener.swift
//  aCultural
//
//  Created by Joao Pires on 12/13/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import UIKit

protocol EventBusListener {
    var busIdentifier: String { get }
    func didReceive<T>(appEvent: AppEvent<T>)
}

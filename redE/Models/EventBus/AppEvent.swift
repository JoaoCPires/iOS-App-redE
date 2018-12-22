//
//  AppEvent.swift
//  aCultural
//
//  Created by Joao Pires on 12/13/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import UIKit

class AppEvent<T> {
    
    var data: T?
    
    init(data: T) {
        self.data = data
    }
}

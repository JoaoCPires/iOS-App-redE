//
//  BusReply.swift
//  Keirmot
//
//  Created by Joao Pires on 12/13/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import UIKit

public class BusReply<T> {
    
    public var data: T?
    public var request: String?
    
    public init(data: T, request: String) {
        self.data = data
        self.request = request
    }
}

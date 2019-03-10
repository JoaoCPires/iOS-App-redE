//
//  BusRequest.swift
//  Keirmot
//
//  Created by Joao Pires on 12/13/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import UIKit

open class BusRequest {

    public let action: String?
    public let stringId: String?
    public let intId: Int?
    public let request: (Void)

    public init(action: String, stringId: String? = nil, intId: Int? = nil, request: (Void)) {

        self.action = action
        self.stringId = stringId
        self.intId = intId
        self.request = request
    }
}


//
//  AppAction.swift
//  aCultural
//
//  Created by Joao Pires on 12/13/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import UIKit

class AppAction {
    
    let action: ActionType?
    let stringID: String?
    let intID: Int?
    
    fileprivate init(action:ActionType, stringID: String?, intID: Int?) {
        
        self.action = action
        self.stringID = stringID
        self.intID = intID
    }
    
    convenience init(withAction action: ActionType) {
        
        self.init(action:action, stringID: nil, intID: nil)
    }
    
    convenience init(withAction action: ActionType, andID stringID: String) {
        
        self.init(action: action, stringID: stringID, intID: nil)
    }
    
    convenience init(withAction action: ActionType, andID intID: Int) {
        
        self.init(action: action, stringID: nil, intID: intID)
    }

}

enum ActionType {
    case allTrainStations
    case trainStation
    case departure
    case none
}

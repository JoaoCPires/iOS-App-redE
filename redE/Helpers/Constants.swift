//
//  Constants.swift
//  redE
//
//  Created by Joao Pires on 12/20/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import UIKit

class Constants {
    
    private static let alphabetString = "abcdefghijklmnopqrstuvwxyz"
    static var alphabet: [String] {
        var composite: [String] = []
        for letter in alphabetString {
            
            composite.append(String(letter))
        }
        return composite
    }
}

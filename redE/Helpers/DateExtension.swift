//
//  DateExtension.swift
//  aCultural
//
//  Created by Joao Pires on 10/28/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import Foundation

extension Date {

    static func nowString() -> String {

        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss"
        let result = formatter.string(from: date)
        return result
    }
    
    static func todayString() -> String {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd'T'23:59:59"
        let result = formatter.string(from: date)
        return result
    }


}

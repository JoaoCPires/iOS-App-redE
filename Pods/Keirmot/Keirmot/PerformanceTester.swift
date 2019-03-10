//
//  PerformanceTester.swift
//  Keirmot
//
//  Created by Joao Pires on 18/07/2018.
//  Copyright © 2018 Tandem Innovation. All rights reserved.
//

import UIKit

/**
 PerformanceTester allows the user to calculate performance times.
 
 ## Available Methods: ##
 - logTime
 - getElapsedTime
 - printElapsedTime
 
 */

open class PerformanceTester {
    /// It contains the registered performance at any given time
    static var log: [String: Performance] = [:]
    public static var printLogs = false
    
    /**
     Register a user determined key to start or end performance measuring.
     
     ### Usage Example: ###
     ````
     PerformanceTester.logTime(.start, description: "Entire Loop")
     for _ in 0...300000 {
         PerformanceTester.logTime(.start, description: "Each Loop")
         //...
         PerformanceTester.logTime(.end, description: "Each Loop")
     }
     PerformanceTester.logTime(.end, description: "Entire Loop")
     ````
     
     - Parameter type: .start or .end of type PerformanceLog
     - Parameter description: a key used to resgister the performance
     
    */
    public static func logTime(_ type: PerformanceLog, description: String) {
        
        if type == .start {
            
            let time = Int((Date().timeIntervalSince1970 * 1000.0).rounded())
            let newPerformance = Performance(with: time)
            log.updateValue(newPerformance, forKey: description)
        }
        else {
            
            let currentTime = Int((Date().timeIntervalSince1970 * 1000.0).rounded())
            guard var performance = log[description] else { return }
            performance.endtime = currentTime
            log.updateValue(performance, forKey: description)
        }
    }
    
    /**
     Prints the elapsed time of a **finished** performance. The user can select the **TimeUnit** which will be reported
     
     ### Usage Example: ###
     ````
     PerformanceTester.printElapsedTime(forDescription: "Entire Loop" in: .minutes)
     ````
     
     - Parameter type: .start or .end of type PerformanceLog
     - Parameter description: the key used to resgister a performance
     */
    public static func printElapsedTime(forDescription description: String, in timeUnit: TimeUnit) {
        
        let timeElapsed = String(getElapsedTime(forDescription: description, in: timeUnit))
        if PerformanceTester.printLogs {
            
            print("Elapsed Time for '\(description)': \(timeElapsed) \(timeUnit.description)")
        }
    }
    
    /**
     Return the elapsed time of a **finished** performance. The user can select the **TimeUnit** which will be reported
     
     ### Usage Example: ###
     ````
     PerformanceTester.getElapsedTime(forDescription: "Entire Loop" in: .minutes)
     ````
     
     - Parameter type: .start or .end of type PerformanceLog
     - Parameter description: the key used to resgister a performance
     - Returns: **Double** describing the time elapsed in the selected **TimeUnit**
     */
    public static func getElapsedTime(forDescription description: String, in timeUnit: TimeUnit) -> Double {
        let index = log.index(forKey: description)
        guard index != nil else { return 0.0}
        let performance = log[index!].value
        var elapsedTime = Double(performance.elapsedTime)
        
        switch timeUnit {
        case .milliseconds:
            elapsedTime = elapsedTime / 1
        case .seconds:
            elapsedTime = elapsedTime / 1000
        case .minutes:
            elapsedTime = (elapsedTime / 1000) / 60
        case .hours:
            elapsedTime = ((elapsedTime / 1000) / 60) / 60
        case .days:
            elapsedTime = (((elapsedTime / 1000) / 60) / 60) / 24
        }
        
        return elapsedTime
    }
    
}

struct Performance {
    
    var startTime: Int
    var endtime: Int
    var elapsedTime: Int {
        return endtime - startTime
    }
    
    init(with time: Int) {
        startTime = time
        endtime = time
    }
    
}

/// Performance Log options
///
/// - start: Marks the Beginning of the log
/// - end: Marks the End of the log
public enum PerformanceLog {
    ///It declares the start of a log
    case start
    ///It declares the end of a log
    case end
}

/**
 Time Unit options.
 
 ````
 case milliseconds
 case seconds
 case minutes
 case hours
 case days
 ````
 
 - **NOTE:**
 Each case also has a describing **String**
 
 */
public enum TimeUnit {
    case milliseconds
    case seconds
    case minutes
    case hours
    case days
    
    var description: String {
        switch self {
        case .milliseconds:
            return "milliseconds"
        case .seconds:
            return "seconds"
        case .minutes:
            return "minutes"
        case .hours:
            return "hours"
        case .days:
            return "days"
        }
    }
}

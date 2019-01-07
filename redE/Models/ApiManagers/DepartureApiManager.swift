//
//  DepartureApiManager.swift
//  redE
//
//  Created by Joao Pires on 12/20/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import UIKit

class DepartureApiManager {
    
    static let shared = DepartureApiManager()
    
    private let baseApi = "http://www.infraestruturasdeportugal.pt/negocios-e-servicos/horarios/partidas"
    
    func getAll(forStation:String, apiReply: @escaping((Departures) -> Void)){
        
        let today = Date.todayString()
        let now = Date.nowString()
        let queryString = "\(baseApi)/\(forStation)/\(now)+\(today)"
        print(queryString)
        let apiUrl = URL(string: queryString)!
        URLSession.shared.dataTask(with: apiUrl) { (jsonData: Data?, jsonResponse: URLResponse?, error: Error?) in
            if jsonResponse != nil {
                
                do {
                    
                    let schedule = try JSONDecoder().decode(Departures.self, from: jsonData!)
                    apiReply(schedule)
                }
                catch {
                    
                    apiReply(Departures())
                }
            }
        }.resume()
    }
}

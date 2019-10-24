//
//  TrainStationManager.swift
//  redE
//
//  Created by Joao Pires on 22/10/2019.
//  Copyright © 2019 Joao Pires. All rights reserved.
//

import Foundation
import KeirmotUtils

protocol TrainStationManagerDelegate {

    func trainStationManager(didSend trainsStations: [BaseStation])
}

protocol TrainStationDetailDelegate {

    func trainStationManager(didSendSchedule trainsStationSchedule: Schedule)
    func trainStationManager(didSendTrainDetail trainsStationDetail: TrainStation)
}

class TrainStationManager {

    private static let baseStationEndPoint: String = "http://www.infraestruturasdeportugal.pt/rede/estacoes/json/"
    private static let departuresEndPoint = "http://www.infraestruturasdeportugal.pt/negocios-e-servicos/horarios/partidas"
    private static let stationDetailEndPoint = "https://keirmot.github.io/apis/rede-app.json"

    private static var allStations = TrainStations()

    // MARK: - Class Methods
    class func getSavedStations(to delegate: TrainStationManagerDelegate) {

    }

    class func getAllStations() {

        guard let url = URL(string: stationDetailEndPoint) else { return }
        let semaphore = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

            let responseCode = response?.httpCode ?? -1
            switch responseCode {
            case 200:
                do {

                    let stationsData = try JSONDecoder().decode(TrainStations.self, from: data!)
                    allStations = stationsData
                    semaphore.signal()
                }
                catch (let error){
                    print(error)
                    semaphore.signal()
                }

            default: semaphore.signal()
            }
        }
        task.resume()
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
    }

    class func getStation(withName query: String, to delegate: TrainStationManagerDelegate) {

        guard let url = URL(string: baseStationEndPoint + query) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

            let responseCode = response?.httpCode ?? -1
            switch responseCode {
            case 200:
                do {

                    let stationData = try JSONDecoder().decode([BaseStation].self, from: data!)
                    stationData.forEach({ $0.details = detailsFor(stationWithId: String( $0.id ))})
                    stationData.forEach({ $0.schedules = getStationSchedulesFor(stationWithId: String($0.id))})
                    print("Done!")
                }
                catch (let error){
                    print(error)
                }

            default: break
            }
        }
        task.resume()
    }

    class func getStationSchedulesFor(stationWithId stationId: String) -> Schedule {

        let semaphore = DispatchSemaphore(value: 0)
        let today = Constants.todayString()
        let now = Constants.nowString()
        let queryString = "\(departuresEndPoint)/\(stationId)/\(now)+\(today)"
        let apiUrl = URL(string: queryString)!
        var result = Schedule()
        URLSession.shared.dataTask(with: apiUrl) { (data, response, error) in

            let responseCode = response?.httpCode ?? -1
            switch responseCode {
            case 200:

                do {

                    let schedule = try JSONDecoder().decode(Schedule.self, from: data!)
                    result = schedule
                    semaphore.signal()
                }
                catch (let error) {

                    print(error)
                    semaphore.signal()
                }
            default: semaphore.signal()
            }
        }.resume()
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        return result
    }

    // MARK: - Private Method
    class private func detailsFor(stationWithId stationId: String) -> TrainStation? {

        var result: TrainStation?
        for station in allStations {

            if station.nodeID == stationId {

                result = station
                break
            }
        }

        return result
    }
}


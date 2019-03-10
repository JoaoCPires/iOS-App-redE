//
//  AnnotationWrapper.swift
//  redE
//
//  Created by Joao Pires on 12/20/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import UIKit
import MapKit

class AnnotationWrapper: NSObject, MKAnnotation {
    
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    let station: TrainStation
    
    init(station: TrainStation) {
        
        self.title = nil
        self.subtitle = station.linha ?? ""
        self.coordinate = station.mapCoordinates
        self.station = station
    }
    
    func viewForStation() -> ViewStation? {
        
        guard let stationView = ViewStation.fromNib() as? ViewStation else { return nil }
        stationView.setup(withStation: self.station)
        stationView.annotation = self
        return stationView
    }
}

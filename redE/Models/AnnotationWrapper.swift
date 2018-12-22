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
        
        self.title = station.name ?? ""
        self.subtitle = station.linha ?? ""
        self.coordinate = station.mapCoordinates
        self.station = station
    }
}

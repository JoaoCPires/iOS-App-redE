//
//  ViewMain.swift
//  redE
//
//  Created by Joao Pires on 12/10/2019.
//  Copyright © 2019 Joao Pires. All rights reserved.
//

import SwiftUI
import MapKit

struct ViewMapContainer: View {

    @State private var userLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(
        latitude: 39.5, longitude: -8.0)

    var body: some View {
        ZStack {
            ViewMap(coordinate: $userLocation)
            ViewMain()
        }
    }

}

struct ViewMapContainer_Previews: PreviewProvider {
    static var previews: some View {
        ViewMapContainer()
    }
}

//
//  ViewMap.swift
//  redE
//
//  Created by Joao Pires on 12/10/2019.
//  Copyright © 2019 Joao Pires. All rights reserved.
//

import SwiftUI
import MapKit

struct ViewMap: UIViewRepresentable {

    @Binding var coordinate: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        
        MKMapView(frame: .zero)
    }

    func updateUIView(_ view: MKMapView, context: Context) {

        let span = MKCoordinateSpan(latitudeDelta: 5.0, longitudeDelta: 4.6)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
    }
}

struct ViewMap_Previews: PreviewProvider {
    @State static var coordenate = CLLocationCoordinate2D(
    latitude: 39.5, longitude: -8.0)

    static var previews: some View {

        ViewMap(coordinate: $coordenate)
    }
}

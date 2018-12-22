//
//  ViewController.swift
//  redE
//
//  Created by Joao Pires on 12/20/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import UIKit
import MapKit

class ControllerStationMap: ControllerBase {
    @IBOutlet weak var mapView: MKMapView!
    
    static let idetifier = "ControllerStationMap"

    private var stations = TrainStations()
    private var initialCoordinates = CLLocationCoordinate2D()

    var delegate: StationDelegate?
    
    // MARK: - Event Bus
    override func busRegistration() {

        self.busIdentifier = ControllerStationMap.idetifier
        let registration = AppAction(withAction: .allTrainStations)
        registrations.append(registration)
    }

    override func didReceive<T>(appEvent: AppEvent<T>) {

        guard let sentStations = appEvent.data as? TrainStations else { return }
        self.stations = sentStations
        setupMapAnnotations()
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {

        super.viewDidLoad()
        setupMap()
    }

    // MARK: - Constructors
    private func setupMap() {
        
        mapView.delegate = self
        initialCoordinates = CLLocationCoordinate2D( latitude: 38.725308, longitude: -9.149855)
    }
    
    private func setupMapAnnotations() {
        mapView.removeAnnotations(mapView.annotations)
        for station in stations {
            
            let stationAnnotation = AnnotationWrapper(station: station)
            mapView.addAnnotation(stationAnnotation)
        }
    }

}

extension ControllerStationMap: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? AnnotationWrapper else { return nil }
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            
            dequeuedView.annotation = annotation
            view = dequeuedView
        }
        else {
            
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: 0, y: 20)
            let buttonDetail = UIButton(type: .detailDisclosure)
            view.rightCalloutAccessoryView = buttonDetail
        }
        view.animatesWhenAdded = true
        view.glyphImage = UIImage(imageLiteralResourceName: "TrainGlyph")
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        guard let annotation = view.annotation as? AnnotationWrapper else { return }
        delegate?.didSelect(station: annotation.station)
    }
}

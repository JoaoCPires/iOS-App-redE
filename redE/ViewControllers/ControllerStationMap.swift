//
//  ViewController.swift
//  redE
//
//  Created by Joao Pires on 12/20/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import UIKit
import MapKit
import Presentr

class ControllerStationMap: ControllerBase {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var labelSelectedFilter: UILabel!
    @IBOutlet weak var buttonFilter: UIButton!
    
    static let idetifier = "ControllerStationMap"

    private var stations = TrainStations()
    private var initialCoordinates = CLLocationCoordinate2D()
    private var presenter: Presentr = {
        let width = ModalSize.full
        let height = ModalSize.full
        let center = ModalCenterPosition.customOrigin(origin: CGPoint(x: 0, y: 0))
        let customType = PresentationType.custom(width: width, height: height, center: center)
        
        let customPresenter = Presentr(presentationType: customType)
        customPresenter.transitionType = TransitionType.crossDissolve
        customPresenter.dismissTransitionType = .crossDissolve
        customPresenter.roundCorners = false
        customPresenter.backgroundColor = .lightGray
        customPresenter.backgroundOpacity = 0
        customPresenter.dismissOnSwipe = false
        return customPresenter
    }()
    
    private var presenterSettings: Presentr = {
        let width = ModalSize.full
        let height = ModalSize.full
        let center = ModalCenterPosition.customOrigin(origin: CGPoint(x: 0, y: 0))
        let customType = PresentationType.custom(width: width, height: height, center: center)
        
        let customPresenter = Presentr(presentationType: customType)
        customPresenter.transitionType = TransitionType.coverVertical
        //customPresenter.dismissTransitionType = .
        customPresenter.roundCorners = false
        customPresenter.backgroundColor = .lightGray
        customPresenter.backgroundOpacity = 0
        customPresenter.dismissOnSwipe = false
        return customPresenter
    }()

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
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        runAction()
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

    // MARK: - Actions
    @IBAction func didTouchFilter(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: ControllerStationFilter.identifier) as! ControllerStationFilter
        controller.delegate = self
        customPresentViewController(presenter, viewController: controller, animated: true, completion: nil)
    }
    
    @IBAction func didTouchSettings(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: ControllerSettings.identifier) as! ControllerSettings
        customPresentViewController(presenterSettings, viewController: controller, animated: true, completion: nil)

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

extension ControllerStationMap: FilterDelegate {
    
    func applyFilter() {
        runAction()
    }
}

//
//  StationViewController.swift
//  redE
//
//  Created by Joao Pires on 14/01/2020.
//  Copyright © 2020 Joao Pires. All rights reserved.
//

import UIKit
import MapKit
import KeirmotUtils

class StationViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var viewFilter: UIView!
    @IBOutlet weak var mapHeight: NSLayoutConstraint!
    
    static let identifier: String = "StationViewController"
    private var trainStation: BaseStation
    private var defaultShadowImage: UIImage?
    private var topPadding: CGFloat!
    private var barHeight: CGFloat!
    private var minDimension: CGFloat!

    //MARK: - Initializers
    init(withStation trainStation: BaseStation) {
        
        self.trainStation = trainStation
        super.init(nibName: StationViewController.identifier, bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstants()
        setupTableView()
        setupMapViewRegion()
        setupMapViewPin()
    }
    
    //MARK: - Setup
    private func setupConstants() {
        
        let window = UIApplication.shared.windows.first
        topPadding = window?.safeAreaInsets.top ?? 0
        barHeight = navigationController?.navigationBar.frame.height ?? 0
        minDimension = topPadding + barHeight
    }
    
    private func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerForCell(HeaderTableViewCell.identifier)
        tableView.registerForCell(TrainStationTableViewCell.identifier)
    }
    
    private func setupMapViewRegion() {
        
        let span = MKCoordinateSpan(latitudeDelta: 0.0025, longitudeDelta: 0.0025)
        let region = MKCoordinateRegion(center: trainStation.mapCoordinates, span: span)
        mapView.setRegion(region, animated: false)
        mapView.isUserInteractionEnabled = false
        mapView.mapType = .mutedStandard
    }
    
    private func setupMapViewPin() {
        
        let newPin = MKPointAnnotation()
        newPin.coordinate = trainStation.mapCoordinates
        mapView.addAnnotation(newPin)
    }
}

extension StationViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func cellFor(_ indexPath: IndexPath) -> TableCellPrototype {
        
        switch indexPath.item {
        case 0:
            return tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifier, for: indexPath) as! HeaderTableViewCell
            
        default:
             return tableView.dequeueReusableCell(withIdentifier: TrainStationTableViewCell.identifier,for: indexPath) as! TrainStationTableViewCell
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = cellFor(indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.item {
            
            case 0: return 250 - (topPadding + barHeight)
            default: return UITableView.automaticDimension
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
                
        let dimentionChange = scrollView.contentOffset.y * -1
        if mapHeight.constant > minDimension || dimentionChange > 0 {
            
            let newDimensions = (250 + dimentionChange) >= minDimension ? (250 + dimentionChange) : minDimension
            mapHeight.constant = newDimensions!
        }
    }
}

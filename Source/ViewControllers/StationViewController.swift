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

protocol StationScheduleDelegate where Self:UIViewController {
    func currentType() -> ScheduleType
    func updateSchedule(to newType: ScheduleType)
    func currentSchedules() -> [ScheduleDetail]
}

class StationViewController: UIViewController, StationScheduleDelegate {
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
    private var selectedScheduleType: ScheduleType = .departure

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
        
        setupNavigationBar()
        setupConstants()
        setupTableView()
        setupMapViewRegion()
        setupMapViewPin()
    }
    
    //MARK: - Setup
    private func setupNavigationBar() {
        
        let imageName = trainStation.isSaved ? "star.fill" : "star"
        let searchButton =  UIBarButtonItem(image: UIImage(systemName: imageName), style: .plain, target: self, action: #selector(didTapSave))
        navigationItem.rightBarButtonItem = searchButton
    }

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
        tableView.registerForCell(StationDetailsTableViewCell.identifier)
        tableView.registerForCell(ContactsTableViewCell.identifier)
        tableView.registerForCell(ScheduleTypeTableViewCell.identifier)
        tableView.registerForCell(ScheduleTableViewCell.identifier)
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
    
    //MARK: - Methods
    @objc
    private func didTapSave() {
        if trainStation.isSaved {
            
            TrainStationManager.removeStation(trainStation)
        }
        else {
       
            TrainStationManager.saveStation(trainStation)
        }
        let imageName = trainStation.isSaved ? "star.fill" : "star"
        let searchButton =  UIBarButtonItem(image: UIImage(systemName: imageName), style: .plain, target: self, action: #selector(didTapSave))
        navigationItem.rightBarButtonItem = searchButton
    }
    
    func currentType() -> ScheduleType {
        
        return selectedScheduleType
    }
    
    func updateSchedule(to newType: ScheduleType) {
        
        selectedScheduleType = newType
        tableView.reloadData()
    }
    
    func currentSchedules() -> [ScheduleDetail] {
        
        if selectedScheduleType == .arrival {
            
            return trainStation.arrivingScheduleDetails
        }
        else {
            
            return trainStation.departingScheduleDetails
        }
    }

}

extension StationViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func cellFor(_ indexPath: IndexPath) -> TableCellPrototype {
        
        switch indexPath.item {
            case 0: return tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifier, for: indexPath) as! HeaderTableViewCell
            case 1: return tableView.dequeueReusableCell(withIdentifier: StationDetailsTableViewCell.identifier,for: indexPath) as! StationDetailsTableViewCell
            case 2: return tableView.dequeueReusableCell(withIdentifier: ContactsTableViewCell.identifier,for: indexPath) as! ContactsTableViewCell
            case 3: return tableView.dequeueReusableCell(withIdentifier: ScheduleTypeTableViewCell.identifier,for: indexPath) as! ScheduleTypeTableViewCell
            default: return tableView.dequeueReusableCell(withIdentifier: ScheduleTableViewCell.identifier,for: indexPath) as! ScheduleTableViewCell
        }
    }
    
    private func dataFor(_ indexPath: IndexPath) -> Any {
        switch indexPath.item {
            case 0, 2, 3: return trainStation
            case 1: return trainStation
            default:
                let currentSchedulesCount = currentSchedules().count
                let currentIndex = indexPath.item - 4
                let data = currentIndex < currentSchedulesCount ? currentSchedules()[currentIndex] : currentSchedules().last
                return data!
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4 + currentSchedules().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = cellFor(indexPath)
        cell.setup(with: dataFor(indexPath))
        
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
        if mapHeight.constant > minDimension || dimentionChange >= -115 {
            
            let newDimensions = (250 + dimentionChange) >= minDimension ? (250 + dimentionChange) : minDimension
            mapHeight.constant = newDimensions!
        }
    }
}

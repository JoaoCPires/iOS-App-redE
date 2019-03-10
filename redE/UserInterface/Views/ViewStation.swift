//
//  ViewStation.swift
//  redE
//
//  Created by Joao on 10/03/2019.
//  Copyright © 2019 Joao Pires. All rights reserved.
//

import UIKit
import MapKit
import Keirmot

class ViewStation: MKMarkerAnnotationView {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonToMap: UIButton!
    @IBOutlet weak var emptyView: UIView!
    
    static let identifier = "ViewStation"
    
    private var station: TrainStation?
    private var departures = Departures()
    private var services = [Service]()
    
    // MARK: - Lifecycle    
    func setup(withStation sentStation: TrainStation) {
        
        station = sentStation
        services = Service.getServices(forStation: self.station!)
        DepartureApiManager.shared.getAll(forStation: station?.nodeID ?? "") { (receivedDepartures: Departures) in
            
            self.departures = receivedDepartures
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
                self.collectionView.reloadData()
                if (self.departures.horarioDetalhe?.count ?? 0) == 0 {

                    self.bringSubviewToFront(self.emptyView)
                }
                else {

                    self.sendSubviewToBack(self.emptyView)
                }
            }
        }
        setupLabels()
        setupTableView()
        setupCollectionView()
        buttonToMap.isHidden = false
    }
    
    // MARK: - Constructors
    private func setupLabels() {
        
        labelTitle.text = station?.name
    }
    
    private func setupTableView() {
        DispatchQueue.main.async {
            
            self.sendSubviewToBack(self.tableView)
            self.bringSubviewToFront(self.tableView)
        }
        tableView.dataSource = self
        tableView.registerForCell(CellSchedule.identifier)
    }
    
    private func setupCollectionView() {
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerForCell(CellServices.identifier)
    }
    
    // MARK: - Methods
    func didSelect(station: TrainStation) {
        
        self.station = station
        setupLabels()
        buttonToMap.isHidden = false
    }
    
    private func showAlert(for service: Service) {
        
        func showAlert(with title: String) {
            
            let parent = self.parentViewController
            let alertController = UIAlertController(
                title: title,
                message: service.name,
                preferredStyle: .alert)
            let actionPhone = UIAlertAction(title: "Ligar", style: UIAlertAction.Style.destructive) { (action: UIAlertAction) in
                
                var phoneNumber = String()
                if service.phone!.contains("/") {
                    phoneNumber = service.phone!.components(separatedBy: "/")[0]
                }
                else {
                    phoneNumber = service.phone!
                }
                phoneNumber = phoneNumber.replacingOccurrences(of: " ", with: "")
                guard let number = URL(string: "tel://" + phoneNumber) else { return }
                UIApplication.shared.open(number, options: [:], completionHandler: nil)
            }
            let actionCancel = UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.cancel)
            alertController.addAction(actionPhone)
            alertController.addAction(actionCancel)
            parent?.present(alertController, animated: true, completion: nil)
        }
        
        let parent = self.parentViewController
        switch service.type {
        case .bikeParking:
            
            let alertController = UIAlertController(
                title: "Bicicletas",
                message: "Esta estação tem estacionamento para bicicletas",
                preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
            alertController.addAction(action)
            parent?.present(alertController, animated: true, completion: nil)
        case .mobility:
            
            let alertController = UIAlertController(
                title: "Acessibilidade",
                message: "Esta estação tem acessos para pessoas com mobilidade reduzida.",
                preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
            alertController.addAction(action)
            parent?.present(alertController, animated: true, completion: nil)
            
        case .hospital: showAlert(with: "Hospital mais Próximo")
        case .fireFighters: showAlert(with: "Bombeiros mais Próximo")
        case .pharmacy:
            let alertController = UIAlertController(
                title: "Farmácia",
                message: "\(service.name!) \nDistancia: \(service.data!)",
                preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
            alertController.addAction(action)
            parent?.present(alertController, animated: true, completion: nil)
            
        case .police: showAlert(with: "Estação de Policia")
        }
    }
    
    // MARK: - Action
    @IBAction func didTapMap(_ sender: Any) {
        
        let latitude: CLLocationDegrees = station!.mapCoordinates.latitude
        let longitude: CLLocationDegrees = station!.mapCoordinates.longitude
        
        let regionDistance: CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Estação de \(String(describing: station!.name!))"
        mapItem.openInMaps(launchOptions: options)
    }
}

extension ViewStation: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return departures.horarioDetalhe?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CellSchedule.identifier,
            for: indexPath) as! CellSchedule
        cell.setup(with: self.departures.horarioDetalhe![indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}

extension ViewStation: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return services.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CellServices.identifier,
            for: indexPath) as! CellServices
        cell.setup(withService: self.services[indexPath.row])
        return cell
    }
}

extension ViewStation: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedCell = collectionView.cellForItem(at: indexPath) as! CellServices
        showAlert(for: selectedCell.service!)
    }
}

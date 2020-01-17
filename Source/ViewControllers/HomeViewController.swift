//
//  HomeViewController.swift
//  redE
//
//  Created by Joao Pires on 14/01/2020.
//  Copyright © 2020 Joao Pires. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewEmpty: UIView!
    @IBOutlet weak var labelEmpty: UILabel!
    
    static let identifier: String = "HomeViewController"

    private var trainStations: [BaseStation]
    
    //MARK: - Initializers
    init() {
        
        trainStations = [BaseStation]()
        super.init(nibName: HomeViewController.identifier, bundle: Bundle.main)
        title = "screen.title.stations".localized
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
        setupEmptyView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        TrainStationManager.getSavedStations(to: self)
    }
    
    //MARK: - Setup
    private func setupNavigationBar() {
        
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
        navigationItem.rightBarButtonItem = searchButton
    }
    
    private func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerForCell(TrainStationTableViewCell.identifier)
    }
    
    private func setupEmptyView() {
        
        labelEmpty.text = "label.add.stations".localized
        viewEmpty.isHidden = false
    }

    
    //MARK: - Actions
    @objc func didTapSearch() {
        
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        trainStations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: TrainStationTableViewCell.identifier,
            for: indexPath) as! TrainStationTableViewCell
        cell.setup(with: trainStations[indexPath.item])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedStation = trainStations[indexPath.item]
        navigationController?.pushViewController(StationViewController(withStation: selectedStation), animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

extension HomeViewController: TrainStationsManagerDelegate {
    
    func trainStationManager(didSend trainsStations: [BaseStation]) {
        
        self.trainStations = trainsStations
        viewEmpty.isHidden = trainStations.count > 0
        tableView.reloadData()
    }

}

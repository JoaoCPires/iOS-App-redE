//
//  SearchViewController.swift
//  redE
//
//  Created by Joao Pires on 14/01/2020.
//  Copyright © 2020 Joao Pires. All rights reserved.
//

import UIKit
import KeirmotUtils

class SearchViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    static let identifier: String = "SearchViewController"

    private var trainStations: [BaseStation]
    private var searchTerm = String()

    //MARK: - Initializers
    init() {
        
        trainStations = [BaseStation]()
        super.init(nibName: SearchViewController.identifier, bundle: Bundle.main)
        title = "screen.title.search".localized
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationItem.hidesSearchBarWhenScrolling = true
    }
        
    //MARK: - Setup
    private func setupSearchBar() {
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "placeholder.search".localized
        
        navigationItem.searchController = searchController
    }
    
    private func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerForCell(TrainStationTableViewCell.identifier)
    }
    
    //MARK: - Methods

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
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

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let query = searchController.searchBar.text else { return }
        searchTerm = query.uppercased()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        TrainStationManager.getStations(withName: searchTerm, to: self)
    }
    
}

extension SearchViewController: TrainStationsManagerDelegate {
    
    func trainStationManager(didSend trainsStations: [BaseStation]) {
        
        navigationItem.searchController?.dismiss(animated: true)
        self.trainStations = trainsStations
        tableView.reloadData()
    }
    
}

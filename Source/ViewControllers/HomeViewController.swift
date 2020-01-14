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
        TrainStationManager.getSavedStations(to: self)
    }
    
    //MARK: - Setup
    private func setupNavigationBar() {
        
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
        navigationItem.rightBarButtonItem = searchButton
    }
    
    //MARK: - Actions
    @objc func didTapSearch() {
        
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
}

extension HomeViewController: TrainStationsManagerDelegate {
    
    func trainStationManager(didSend trainsStations: [BaseStation]) {
        
        self.trainStations = trainsStations
    }

}

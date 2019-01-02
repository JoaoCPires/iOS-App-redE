//
//  ControllerStationFilter.swift
//  redE
//
//  Created by Joao Pires on 12/22/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import UIKit

protocol FilterDelegate {

    func applyFilter()
}

class ControllerStationFilter: ControllerBase {
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var pickerView: UIPickerView!

    static let identifier = "ControllerStationFilter"

    private var filters = [String]()
    private var selectedLine = String()
    private var filteredIndex = 0

    var delegate: FilterDelegate?

    override func viewDidLoad() {

        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        filters = Cache.repository.trainStations.getLines()
        selectedLine = TrainStationManager.shared.getSetFilter()
        if let index = filters.firstIndex(of: selectedLine) {

            filteredIndex = index
        }
    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        pickerView.selectRow(filteredIndex, inComponent: 0, animated: false)
    }

    // MARK: - Actions
    @IBAction func didTapCAncel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func didTapSave(_ sender: UIButton) {

        TrainStationManager.shared.setNew(filter: selectedLine)
        delegate?.applyFilter()
        self.dismiss(animated: true, completion: nil)
    }
}

extension ControllerStationFilter: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.filters.count
    }

}

extension ControllerStationFilter: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        return filters[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedLine = filters[row]
    }
}


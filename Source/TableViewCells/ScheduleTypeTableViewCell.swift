//
//  ScheduleTypeTableViewCell.swift
//  redE
//
//  Created by Joao Pires on 16/01/2020.
//  Copyright © 2020 Joao Pires. All rights reserved.
//

import UIKit
import KeirmotUtils

class ScheduleTypeTableViewCell: UITableViewCell, TableCellPrototype {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    static var identifier = "ScheduleTypeTableViewCell"

    func setup(with data: Any?) {
        
        setupSegmentedControl()
    }
    
    private func setupSegmentedControl() {
        
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "label.arrivals".localized, at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "label.departures".localized, at: 0, animated: false)
        
        guard let parent = parentViewController as? StationViewController else {
            segmentedControl.selectedSegmentIndex = 0
            return
        }
        let selectedType = parent.currentType()
        segmentedControl.selectedSegmentIndex = selectedType.indexForType
    }
    
    @IBAction func didSelectNewType(_ sender: UISegmentedControl) {
        
        guard let parent = parentViewController as? StationViewController else { return }
        parent.updateSchedule(to: ScheduleType.typeForIndex(sender.selectedSegmentIndex))
    }
}

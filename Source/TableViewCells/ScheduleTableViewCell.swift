//
//  ScheduleTableViewCell.swift
//  redE
//
//  Created by Joao Pires on 16/01/2020.
//  Copyright © 2020 Joao Pires. All rights reserved.
//

import UIKit
import KeirmotUtils

class ScheduleTableViewCell: UITableViewCell, TableCellPrototype {
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var viewSemaphore: UIView!
    @IBOutlet weak var labelDestination: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
    
    static var identifier = "ScheduleTableViewCell"
    private var schedule: ScheduleDetail!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        setupLabels()
    }
    
    func setup(with data: Any?) {
        
        if let scheduleData = data as? ScheduleDetail {
            
            schedule = scheduleData
            setupContainerView()
            setupViewSemaphore()
            setupLabels()
            setupImage()
        }
    }
    
    private func setupContainerView() {
        
        viewContainer.layer.cornerRadius = 10
        viewContainer.layer.masksToBounds = false
        viewContainer.layer.shadowColor = UIColor.black.cgColor
        viewContainer.layer.shadowOpacity = 0.2
        viewContainer.layer.shadowOffset = CGSize(width: -1, height: 1)
        viewContainer.layer.shadowRadius = 3
    }
    
    private func setupViewSemaphore() {
        
        viewSemaphore.backgroundColor = schedule.status.color
        viewSemaphore.layer.cornerRadius = viewSemaphore.frame.height / 2
    }
    
    private func setupLabels() {
        
        guard let parent = parentViewController as? StationViewController else { return }
        let scheduleType = parent.currentType()
        labelDestination.text = schedule.nameFor(scheduleType)
        labelStatus.text = schedule.status.description
        labelTime.text = schedule.timeFor(scheduleType)
    }
    
    private func setupImage() {
        
        imageIcon.image = schedule.status.icon
        imageIcon.tintColor = .white
    }
}

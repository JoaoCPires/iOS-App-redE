//
//  ControllerSettings.swift
//  redE
//
//  Created by Joao Pires on 05/01/2019.
//  Copyright © 2019 Joao Pires. All rights reserved.
//

import UIKit

class ControllerSettings: ControllerBase {

    static let identifier = "ControllerSettings"
    
    @IBAction func didTapDismiss(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
}

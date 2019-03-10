//
//  ControllerSettings.swift
//  redE
//
//  Created by Joao Pires on 05/01/2019.
//  Copyright © 2019 Joao Pires. All rights reserved.
//

import UIKit

class ControllerSettings: ControllerBase {
    @IBOutlet weak var labelVersion: UILabel!
    @IBOutlet weak var labelBuild: UILabel!
    
    static let identifier = "ControllerSettings"
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
        labelVersion.text = "Versão: \(appVersion!)"
        
        let appBuild = Bundle.main.infoDictionary!["CFBundleVersion"] as? String
        labelBuild.text = "(build \(appBuild!))"

    }
    @IBAction func didTapDismiss(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func didTapVitor(_ sender: Any) {
        guard let url = URL(string: "https://vitorgalvao.com/") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func didTapPulley(_ sender: Any) {
        guard let url = URL(string: "https://github.com/52inc/Pulley") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func didTapPresentr(_ sender: Any) {
        guard let url = URL(string: "https://github.com/IcaliaLabs/Presentr") else { return }
        UIApplication.shared.open(url)
    }
}

//
//  NavigationConfigurator.swift
//  redE
//
//  Created by Joao Pires on 25/10/2019.
//  Copyright © 2019 Joao Pires. All rights reserved.
//

import SwiftUI
import UIKit

struct NavigationConfigurator: UIViewControllerRepresentable {

    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {

        UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {

        if let nc = uiViewController.navigationController {

            self.configure(nc)
        }
    }

}

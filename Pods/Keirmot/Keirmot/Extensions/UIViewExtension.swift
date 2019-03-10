//
//  UIViewExtension.swift
//  aCultural
//
//  Created by Joao Pires on 11/24/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import UIKit

extension UIView {
    public var parentViewController: UIViewController? {
        
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                
                return viewController
            }
        }
        return nil
    }
}

//
//  UIViewExtension.swift
//  redE
//
//  Created by Joao on 10/03/2019.
//  Copyright © 2019 Joao Pires. All rights reserved.
//

import UIKit

extension UIView {
    
    var firstResponder: UIView? {
        
        guard !isFirstResponder else { return self }
        
        for subview in subviews {
            if let firstResponder = subview.firstResponder {
                return firstResponder
            }
        }
        
        return nil
    }
    
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
}

//
//  LoadingViewController.swift
//  Cortado
//
//  Created by Joao Pires on 08/01/2020.
//  Copyright © 2020 Cortado AG. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    init() {
        
        super.init(nibName: "LoadingViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        activityIndicator.startAnimating()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        activityIndicator.stopAnimating()
    }
}

extension UIViewController {
    
    func showLoadingView() {
        
        guard !(self is LoadingViewController) else { return }
        let loadingController = LoadingViewController()
        loadingController.modalPresentationStyle = .overFullScreen
        loadingController.modalTransitionStyle = .crossDissolve
        present(loadingController, animated: true)
    }
    
    func removeLoadingView() {
        
        guard !(self is LoadingViewController) else { return }
        if let topController = UIApplication.topViewController(), topController is LoadingViewController {
            
            dismiss(animated: true)
        }
    }
}


extension UIApplication {
    
    class func topViewController(_ viewController: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {
        
        if let nav = viewController as? UINavigationController { return topViewController(nav.visibleViewController) }
        
        if let tab = viewController as? UITabBarController {
            
            let moreNavigationController = tab.moreNavigationController
            if let top = moreNavigationController.topViewController, top.view.window != nil {
                
                return topViewController(top)
            }
            else if let selected = tab.selectedViewController {
            
                return topViewController(selected)
            }
        }
        
        if let presented = viewController?.presentedViewController {
            
            return topViewController(presented)
        }
        
        if viewController?.popoverPresentationController != nil {
            
            return viewController?.presentingViewController
        }
        
        return viewController
    }
}

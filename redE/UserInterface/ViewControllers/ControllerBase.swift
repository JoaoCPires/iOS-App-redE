//
//  ViewController.swift
//  okoko
//
//  Created by Joao Pires on 12/8/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import UIKit

class ControllerBase: UIViewController, EventBusListener {

    var registrations = [AppAction]()
    var busIdentifier = "BusControllerBase"

    override func viewDidLoad() {

        super.viewDidLoad()
        busRegistration()
        register()
    }

    func busRegistration() {
        //Use this method to override the registration and busIdentifier
    }

    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(animated)
        runAction()
    }

    override func viewDidDisappear(_ animated: Bool) {

        super.viewDidDisappear(animated)
        unregister()
    }

    func didReceive<T>(appEvent: AppEvent<T>) {
        //Use this method to override the receiving AppEvents
    }
    
    func register() {

        for registration in registrations {
            
            EventBus.global.register(listener: self, inRegistry: registration)
        }
    }
    
    func unregister() {
        
        for registration in registrations {
            
            EventBus.global.unregister(listener: self, inRegistry: registration)
        }

    }
    
    func runAction() {
        
        for registration in registrations {
            
            EventBus.global.runAction(for: registration)
        }
    }

}


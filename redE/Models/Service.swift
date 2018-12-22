//
//  Service.swift
//  redE
//
//  Created by Joao Pires on 12/21/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import UIKit

class Service {
    var type: ServiceType
    var phone: String?
    var name: String?
    var data: String?
    var image: UIImage!
    
    init(withStation sentStation: TrainStation, forType type: ServiceType) {
        self.type = type
        self.build(forStation: sentStation)
    }
    
    private func build(forStation sentStation: TrainStation) {
        switch self.type {
        case .bikeParking:
            self.image = UIImage(imageLiteralResourceName: "IconBicycle")
        case .fireFighters:
            self.image = UIImage(imageLiteralResourceName: "IconFire")
            self.name = sentStation.bombeirosNome
            self.phone = sentStation.bombeirosTelefone
        case .hospital:
            self.image = UIImage(imageLiteralResourceName: "IconHospital")
            self.name = sentStation.hospitalNome
            self.phone = sentStation.hospitalTelefone
        case .pharmacy:
            self.image = UIImage(imageLiteralResourceName: "IconPharmacy")
            self.data = sentStation.farmaciaDistancia
            self.name = sentStation.farmaciaNome
        case .police:
            self.image = UIImage(imageLiteralResourceName: "IconShield")
            self.phone = sentStation.policiaTelefone
            self.name = sentStation.policiaNome
        case .mobility:
            self.image = UIImage(imageLiteralResourceName: "IconAccessibility")
            self.data = sentStation.acessoMobilidadeReduzida
        }
    }
    
    static func getServices(forStation sentStation: TrainStation)->[Service] {
        var allServices = [Service]()
        if sentStation.hospitalTelefone != "" {
            allServices.append(Service(withStation: sentStation, forType: .hospital))
        }
        if sentStation.policiaTelefone != "" {
            allServices.append(Service(withStation: sentStation, forType: .police))
        }
        if sentStation.bombeirosTelefone != "" {
            allServices.append(Service(withStation: sentStation, forType: .fireFighters))
        }
        if sentStation.farmaciaNome != "" {
            allServices.append(Service(withStation: sentStation, forType: .pharmacy))
        }
        if sentStation.estacionamentoBicicletas == "Sim" {
            allServices.append(Service(withStation: sentStation, forType: .bikeParking))
        }
        if sentStation.acessoMobilidadeReduzida == "Sim" {
            allServices.append(Service(withStation: sentStation, forType: .mobility))
        }
        return allServices
    }
}

enum ServiceType {
    case bikeParking
    case fireFighters
    case hospital
    case pharmacy
    case police
    case mobility
}

//
//  TrainStationsApiManager.swift
//  redE
//
//  Created by Joao Pires on 12/20/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TrainStationsApiManager {

    static let shared = TrainStationsApiManager()
    var ref: DatabaseReference = Database.database().reference()

    func getAll(apiReply: @escaping((TrainStations) -> Void)) {

        ref.child("tag").observeSingleEvent(of: .value) { (snap:DataSnapshot) in
            let newTag = snap.value as! String
            if !(newTag == Cache.repository.stationTag) {
                PersistencyManager.shared.save(newTag: newTag)
                var allTrainStation = TrainStations()
                self.ref.child("train-stations").observeSingleEvent(of: .value, with: { (snapshot) in
                    let allStations = snapshot.value as? NSDictionary
                    for (_, value) in allStations! {
                        
                        guard let stationValue = value as? NSDictionary else { return }
                        let nameNew = stationValue["name"] as? String
                        let horarioEstacaoNew = stationValue["schedule"] as? String
                        let moradaNew = stationValue["address"] as? String
                        let acessoMobilidadeReduzidaNew = stationValue["reduced-accessibility"] as? String
                        let aeroportoNomeNew = stationValue["closest-airport"] as? String
                        let aeroportoDistanciaNew = stationValue["airport-distance"] as? String
                        let farmaciaNomeNew = stationValue["pharmacy-name"] as? String
                        let farmaciaDistanciaNew = stationValue["pharmacy-distance"] as? String
                        let bombeirosNomeNew = stationValue["firefighters-name"] as? String
                        let bombeirosTelefoneNew = stationValue["firefighters-phone"] as? String
                        let policiaNomeNew = stationValue["police-name"] as? String
                        let policiaTelefoneNew = stationValue["police-phone"] as? String
                        let hospitalNomeNew = stationValue["hospital-name"] as? String
                        let hospitalTelefoneNew = stationValue["hospital-phone"] as? String
                        let coordenadasNew = stationValue["coordinates"] as? String
                        let nodeIDNew = stationValue["node-id"] as? String
                        let linhaNew = stationValue["line"] as? String
                        let anoContrucaoNew = stationValue["year-built"] as? String
                        let epClassificadoInteresseNew = stationValue["classification"] as? String
                        let telefoneNew = stationValue["phone"] as? String
                        let equipamentomobilidadeReduzidaPlataformasNew = stationValue["recuced-mobility-equipment"] as? String
                        let estacionamentoBicicletasNew = stationValue["bike-parking"] as? String
                        let cidadeProximaNew = stationValue["near-city"] as? String
                        let cidadeProximaDistanciaNew = stationValue["near-city-distance"] as? String
                        let centroCidadeProximaDistanciaNew = stationValue["cear-city-center-distance"] as? String
                        let pkNew = stationValue["pk"] as? String
                        
                        let newStation = TrainStation(
                            name: nameNew,
                            horarioEstacao: horarioEstacaoNew,
                            morada: moradaNew,
                            acessoMobilidadeReduzida: acessoMobilidadeReduzidaNew,
                            aeroportoNome: aeroportoNomeNew,
                            aeroportoDistancia: aeroportoDistanciaNew,
                            farmaciaNome: farmaciaNomeNew,
                            farmaciaDistancia: farmaciaDistanciaNew,
                            bombeirosNome: bombeirosNomeNew,
                            bombeirosTelefone: bombeirosTelefoneNew,
                            policiaNome: policiaNomeNew,
                            policiaTelefone: policiaTelefoneNew,
                            hospitalNome: hospitalNomeNew,
                            hospitalTelefone: hospitalTelefoneNew,
                            coordenadas: coordenadasNew,
                            nodeID: nodeIDNew,
                            linha: linhaNew,
                            anoContrucao: anoContrucaoNew,
                            epClassificadoInteresse: epClassificadoInteresseNew,
                            telefone: telefoneNew,
                            equipamentomobilidadeReduzidaPlataformas: equipamentomobilidadeReduzidaPlataformasNew,
                            estacionamentoBicicletas: estacionamentoBicicletasNew,
                            cidadeProxima: cidadeProximaNew,
                            cidadeProximaDistancia: cidadeProximaDistanciaNew,
                            centroCidadeProximaDistancia: centroCidadeProximaDistanciaNew,
                            pk: pkNew)
                        allTrainStation.append(newStation)
                    }
                    apiReply(allTrainStation)
                }) { (error) in
                    print(error.localizedDescription)
                }

            }
        }
    }
}

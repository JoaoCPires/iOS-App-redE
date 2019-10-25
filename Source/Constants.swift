//
//  Constants.swift
//  pokeapp
//
//  Created by Joao Pires on 20/10/2019.
//  Copyright © 2019 Joao Pires. All rights reserved.
//

import UIKit

typealias AppDimensions = Constants.Dimensions
typealias AppColors = Constants.Colors
typealias PreviewObject = Constants.Dummy
typealias AppAction = ()->()

struct Constants {

    struct Dimensions {

        static var screenWidth: CGFloat {

            UIScreen.main.bounds.width
        }

        static var fabSize: CGFloat = 50

        static var fabCornerRadius: CGFloat = fabSize / 2

    }

    struct Colors {
        static var colorCanceled = UIColor(named: "colorCanceled")!
        static var colorDelayed = UIColor(named: "colorDelayed")!
        static var colorOnTime = UIColor(named: "colorOnTime")!
    }

    struct Dummy {
        static var station: BaseStation {
            let details = TrainStation(
                name: "LISBOA-APOLÓNIA",
                horarioEstacao: nil,
                morada: "Largo dos Caminhos de Ferro - Estação de Santa Apolónia, Lisboa",
                acessoMobilidadeReduzida: "Sim",
                aeroportoNome: nil,
                aeroportoDistancia: nil,
                farmaciaNome: nil,
                farmaciaDistancia: nil,
                bombeirosNome: "Regimento Sapadores Bombeiros de Lisboa",
                bombeirosTelefone: "808 215 215",
                policiaNome: "4ª Esquadra de Segurança a Transportes Públicos",
                policiaTelefone: "218 946 046",
                hospitalNome: "Hospital de Santa Maria",
                hospitalTelefone: "217 805 000",
                coordenadas: "lat=41.547843270000001 ; long=-8.4346801609999993",
                nodeID: nil,
                linha: "Linha de Sintra",
                anoContrucao: nil,
                epClassificadoInteresse: nil,
                telefone: "218 841 000",
                equipamentomobilidadeReduzidaPlataformas: nil,
                estacionamentoBicicletas: "Sim",
                cidadeProxima: nil,
                cidadeProximaDistancia: nil,
                centroCidadeProximaDistancia: nil,
                pk: nil)

            let origen = Comboio(id: 9430007, nome: "LISBOA-APOLÓNIA")
            let destino = Comboio(id: 9449007, nome: "GUARDA")
            let status = EstadoComboio(id: 2, nome: "À tabela", descricao: "À tabela")

            let scheduleDetail = ScheduleDetail(id: 513, nome: "IC", horaChegada: "24-10-2019 12:30:00", horaPartida: "24-10-2019 12:30:00", comboio: nil, estacaoOrigem: origen, estacaoDestino: destino, operador: nil, estadoComboio: status)

            let schedule = Schedule()
            schedule.scheduleDetail = [scheduleDetail,scheduleDetail,scheduleDetail,scheduleDetail,scheduleDetail,scheduleDetail]

            return BaseStation(id: 9430007, name: "LISBOA-APOLÓNIA", details: details, arrivingSchedules: schedule, departingSchedules: schedule)
        }
    }

    static func nowString() -> String {

        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss"
        let result = formatter.string(from: date)
        return result
    }

    static func todayString() -> String {

        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd'T'23:59:59"
        let result = formatter.string(from: date)
        return result
    }

}

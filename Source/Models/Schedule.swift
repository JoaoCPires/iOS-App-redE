//
//  Schedule.swift
//  redE
//
//  Created by Joao Pires on 12/20/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import Foundation

enum ScheduleType {
    case arrival
    case departure
}

enum ScheduleStatus {
    case delayed
    case onTime
    case canceled

    var description: String {
        switch self {
        case .delayed: return "Atrasado"
        case .onTime: return "À Tabela"
        case .canceled: return "Suprimido"
        }
    }
}

class Schedule: Codable {
    var scheduleDetail: [ScheduleDetail]?
    
    enum CodingKeys: String, CodingKey {
        case scheduleDetail = "HorarioDetalhe"
    }
    
    init() {
        
    }
}

class ScheduleDetail: Codable, Identifiable {
    let id: Int
    let nome, horaChegada, horaPartida: String?
    let comboio, estacaoOrigem, estacaoDestino, operador: Comboio?
    let estadoComboio: EstadoComboio?

    var status: ScheduleStatus {

        let status = estadoComboio?.nome ?? String()
        var result = ScheduleStatus.onTime

        result = status.contains("trasado") ? .delayed : result
        result = status.contains("uprimido") ? .canceled : result
        
        return result

    }

    func nameFor(_ type: ScheduleType) -> String {

        switch type {
        case .arrival:
            return "Origem: \((estacaoOrigem?.nome ?? String()).capitalized(with: Locale(identifier: "pt")))"

        case .departure:
            return "Destino: \((estacaoDestino?.nome ?? String()).capitalized(with: Locale(identifier: "pt")))"
        }
    }

    func timeFor(_ type: ScheduleType) -> String {

        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "pt")

        switch type {
        case .arrival:
            let date = dateFormatter.date(from: horaChegada!)!
            let components = calendar.dateComponents([.hour, .minute], from: date)

            return ("Chegada: \(components.hour ?? 0):\(components.minute ?? 0)").capitalized(with: Locale(identifier: "pt"))

        case .departure:
            let date = dateFormatter.date(from: horaPartida!)!
            let components = calendar.dateComponents([.hour, .minute], from: date)

            return ("Partida: \(components.hour ?? 0):\(components.minute ?? 0)").capitalized(with: Locale(identifier: "pt"))
        }
    }

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case nome = "Nome"
        case horaChegada = "HoraChegada"
        case horaPartida = "HoraPartida"
        case comboio = "Comboio"
        case estacaoOrigem = "EstacaoOrigem"
        case estacaoDestino = "EstacaoDestino"
        case operador = "Operador"
        case estadoComboio = "EstadoComboio"
    }
    
    init(id: Int, nome: String?, horaChegada: String?, horaPartida: String?, comboio: Comboio?, estacaoOrigem: Comboio?, estacaoDestino: Comboio?, operador: Comboio?, estadoComboio: EstadoComboio?) {
        self.id = id
        self.nome = nome
        self.horaChegada = horaChegada
        self.horaPartida = horaPartida
        self.comboio = comboio
        self.estacaoOrigem = estacaoOrigem
        self.estacaoDestino = estacaoDestino
        self.operador = operador
        self.estadoComboio = estadoComboio
    }
    
    convenience init() {
        self.init(id: 0, nome: nil, horaChegada: nil, horaPartida: nil, comboio: nil, estacaoOrigem: nil, estacaoDestino: nil, operador: nil, estadoComboio: nil)
    }
}

class Comboio: Codable {
    let id: Int?
    let nome: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case nome = "Nome"
    }
    
    init(id: Int?, nome: String?) {
        self.id = id
        self.nome = nome
    }
}

class EstadoComboio: Codable {
    let id: Int?
    let nome, descricao: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case nome = "Nome"
        case descricao = "Descricao"
    }
    
    init(id: Int?, nome: String?, descricao: String?) {
        self.id = id
        self.nome = nome
        self.descricao = descricao
    }
}

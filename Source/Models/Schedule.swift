//
//  Schedule.swift
//  redE
//
//  Created by Joao Pires on 12/20/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import UIKit

enum ScheduleType {
    case arrival
    case departure
    
    var indexForType: Int {
        if self == .arrival {
            return 1
        }
        else {
            return 0
        }
    }
    
    static func typeForIndex(_ index: Int) -> ScheduleType {
        if index == 1 {
            return .arrival
        }
        else {
            return .departure
        }

    }
}

enum ScheduleStatus {
    case delayed
    case onTime
    case canceled

    var description: String {
        switch self {
        case .delayed: return "label.delayed".localized
        case .onTime: return "label.on.time".localized
        case .canceled: return "label.canceled".localized
        }
    }
    
    var color: UIColor {
        switch self {
            case .onTime: return AppColors.colorOnTime
            case .delayed: return AppColors.colorDelayed
            case .canceled: return AppColors.colorCanceled
        }
    }
    
    var icon: UIImage {

        switch self {
            case .onTime: return UIImage(named: "icOnTime")!
            case .delayed: return UIImage(named:"icDelayed")!
            case .canceled: return UIImage(named:"icCanceled")!
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
        var result = ScheduleStatus.delayed

        result = status.contains("À tabela") ? .onTime : result
        result = status.contains("SUPRIMIDO") ? .canceled : result

        return result

    }

    func nameFor(_ type: ScheduleType) -> String {

        switch type {
        case .arrival:
            return "\("label.origin".localized): \((estacaoOrigem?.nome ?? String()).capitalized(with: Locale(identifier: "pt")))"

        case .departure:
            return "\("label.destination".localized): \((estacaoDestino?.nome ?? String()).capitalized(with: Locale(identifier: "pt")))"
        }
    }

    func timeFor(_ type: ScheduleType) -> String {

        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "pt")

        switch type {
        case .arrival:
            
            let date: Date
            if let dateWithDefaultFormate = dateFormatter.date(from: horaChegada!) {
                
                date = dateWithDefaultFormate
            }
            else {
                
                dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
                date = dateFormatter.date(from: horaChegada!)!
            }

            let components = calendar.dateComponents([.hour, .minute], from: date)
            let hour = ((components.hour ?? 0) < 10) ? "0\((components.hour ?? 0))" : "\(components.hour ?? 0)"
            let minute = ((components.minute ?? 0) < 10) ? "0\((components.minute ?? 0))" : "\(components.minute ?? 0)"

            return ("\("label.arrival".localized): \(hour):\(minute)").capitalized(with: Locale(identifier: "pt"))

        case .departure:
            let date: Date
            if let dateWithDefaultFormate = dateFormatter.date(from: horaPartida!) {
                
                date = dateWithDefaultFormate
            }
            else {
                
                dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
                date = dateFormatter.date(from: horaPartida!)!
            }
            let components = calendar.dateComponents([.hour, .minute], from: date)
            let hour = ((components.hour ?? 0) < 10) ? "0\((components.hour ?? 0))" : "\(components.hour ?? 0)"
            let minute = ((components.minute ?? 0) < 10) ? "0\((components.minute ?? 0))" : "\(components.minute ?? 0)"

            return ("\("label.departure".localized): \(hour):\(minute)").capitalized(with: Locale(identifier: "pt"))
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

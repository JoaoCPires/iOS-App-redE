//
//  Departures.swift
//  redE
//
//  Created by Joao Pires on 12/20/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import Foundation

class Departures: Codable {
    var horarioDetalhe: [HorarioDetalhe]?
    
    enum CodingKeys: String, CodingKey {
        case horarioDetalhe = "HorarioDetalhe"
    }
    
    init() {
        
    }
}

class HorarioDetalhe: Codable {
    let id: Int?
    let nome, horaChegada, horaPartida: String?
    let comboio, estacaoOrigem, estacaoDestino, operador: Comboio?
    let estadoComboio: EstadoComboio?
    
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
    
    init(id: Int?, nome: String?, horaChegada: String?, horaPartida: String?, comboio: Comboio?, estacaoOrigem: Comboio?, estacaoDestino: Comboio?, operador: Comboio?, estadoComboio: EstadoComboio?) {
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
        self.init(id: nil, nome: nil, horaChegada: nil, horaPartida: nil, comboio: nil, estacaoOrigem: nil, estacaoDestino: nil, operador: nil, estadoComboio: nil)
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

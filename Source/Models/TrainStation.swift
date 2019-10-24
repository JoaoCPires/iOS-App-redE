//
//  TrainStation.swift
//  redE
//
//  Created by Joao Pires on 12/20/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import UIKit
import MapKit

typealias TrainStations = [TrainStation]

extension Array where Element: TrainStation {
    
    func getLines() -> [String] {
        
        var allLines = [String]()
        for element in self {
            
            if !allLines.contains(element.linha!) {
                
                allLines.append(element.linha!)
            }
        }
        return allLines.sorted()
    }
    
    func filtered(forLine selectedLine: String) -> TrainStations{
        
        var selectedStations = TrainStations()
        for station in self {
            
            if station.linha! == selectedLine {
                
                selectedStations.append(station)
            }
        }
        return selectedStations
    }
    
}

enum StationAmeneties {
    case bikeParking
    case reducedMobility
    case pharmacy

    var imageName: String {
        switch self {
        case .bikeParking: return  "IconBicycle"
        case .reducedMobility: return "IconAccessibility"
        case .pharmacy: return "IconPharmacy"
        }
    }
}

struct Contact: Identifiable {
    let id = UUID()
    var imageName: String
    var title: String
    var phoneNumber: String
}

class BaseStation: Codable, Identifiable {
    let id: Int
    let name: String
    var details: TrainStation!
    var arrivingSchedules: Schedule!
    var departingSchedules: Schedule!

    // MARK: - Computed Properties
    var stationName: String { (details.name ?? String()).capitalized(with: Locale(identifier: "pt")) }
    var stationLine: String { details.linha ?? String() }
    var stationAddress: String { details.morada ?? String() }
    var hasAmeneties: Bool { ameneties.count > 0 }
    var hasContacts: Bool { contacts.count > 0 }
    var mapCoordinates: CLLocationCoordinate2D {

        var coordinates = CLLocationCoordinate2D()
        let coords = details.coordenadas!.components(separatedBy: " ; ")
        let latString = coords[0].components(separatedBy: "lat=")[1]
        let longString = coords[1].components(separatedBy: "long=")[1]
        coordinates = CLLocationCoordinate2D(latitude: Double(latString)!, longitude: Double(longString)!)

        return coordinates
    }
    var ameneties: [StationAmeneties] {

        var result = [StationAmeneties]()
        if details?.acessoMobilidadeReduzida != "" || details?.acessoMobilidadeReduzida != "Não" {

            result.append(.reducedMobility)
        }
        if details?.estacionamentoBicicletas != "" || details?.estacionamentoBicicletas != "Não" {

            result.append(.bikeParking)
        }

        return result
    }
    var contacts: [Contact] {

        var result = [Contact]()
        if details?.telefone != nil && details?.telefone != "" {

            result.append(Contact(imageName: "TrainGlyph", title: stationName, phoneNumber: details?.telefone ?? String() ))
        }
        if details?.policiaNome != nil && details?.policiaNome != "" {

            let name = details?.policiaNome ?? String()
            let phoneNumber = details?.policiaTelefone ?? String()
            result.append(Contact(imageName: "IconShield", title: name, phoneNumber: phoneNumber ))
        }
        if details?.bombeirosNome != nil && details?.bombeirosNome != "" {

            let name = details?.bombeirosNome ?? String()
            let phoneNumber = details?.bombeirosTelefone ?? String()
            result.append(Contact(imageName: "IconShield", title: name, phoneNumber: phoneNumber ))
        }

        return result
    }
    var arrivingScheduleDetails: [ScheduleDetail] {
        arrivingSchedules?.scheduleDetail ?? [ScheduleDetail]()
    }
    var departingScheduleDetails: [ScheduleDetail] {
        departingSchedules?.scheduleDetail ?? [ScheduleDetail]()
    }

    // MARK: - Initializer
    internal init(id: Int, name: String, details: TrainStation?, arrivingSchedules: Schedule?, departingSchedules: Schedule?) {
        self.id = id
        self.name = name
        self.details = details
        self.arrivingSchedules = arrivingSchedules
        self.departingSchedules = departingSchedules
    }

}

class TrainStation: NSObject, Codable {
    // MARK: - Properties
    var name: String?
    var horarioEstacao, morada, acessoMobilidadeReduzida: String?
    var aeroportoNome, aeroportoDistancia, farmaciaNome, farmaciaDistancia: String?
    var bombeirosNome, bombeirosTelefone, policiaNome, policiaTelefone: String?
    var hospitalNome, hospitalTelefone, coordenadas, nodeID: String?
    var linha, anoContrucao, epClassificadoInteresse, telefone: String?
    var equipamentomobilidadeReduzidaPlataformas, estacionamentoBicicletas, cidadeProxima, cidadeProximaDistancia: String?
    var centroCidadeProximaDistancia, pk: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case horarioEstacao = "schedule"
        case morada = "address"
        case acessoMobilidadeReduzida = "reduced-accessibility"
        case aeroportoNome = "closest-airport"
        case aeroportoDistancia = "airport-distance"
        case farmaciaNome = "pharmacy-name"
        case farmaciaDistancia = "pharmacy-distance"
        case bombeirosNome = "firefighters-name"
        case bombeirosTelefone = "firefighters-phone"
        case policiaNome = "police-name"
        case policiaTelefone = "police-phone"
        case hospitalNome = "hospital-name"
        case hospitalTelefone = "hospital-phone"
        case coordenadas = "coordinates"
        case nodeID = "node-id"
        case linha = "line"
        case anoContrucao = "year-built"
        case epClassificadoInteresse = "EPClassificadoInteresse"
        case telefone = "phone"
        case equipamentomobilidadeReduzidaPlataformas = "recuced-mobility-equipment"
        case estacionamentoBicicletas = "bike-parking"
        case cidadeProxima = "near-city"
        case cidadeProximaDistancia = "near-city-distance"
        case centroCidadeProximaDistancia = "cear-city-center-distance"
        case pk = "pk"
    }

    init(name: String?, horarioEstacao: String?, morada: String?, acessoMobilidadeReduzida: String?, aeroportoNome: String?, aeroportoDistancia: String?, farmaciaNome: String?, farmaciaDistancia: String?, bombeirosNome: String?, bombeirosTelefone: String?, policiaNome: String?, policiaTelefone: String?, hospitalNome: String?, hospitalTelefone: String?, coordenadas: String?, nodeID: String?, linha: String?, anoContrucao: String?, epClassificadoInteresse: String?, telefone: String?, equipamentomobilidadeReduzidaPlataformas: String?, estacionamentoBicicletas: String?, cidadeProxima: String?, cidadeProximaDistancia: String?, centroCidadeProximaDistancia: String?, pk: String?) {
        self.name = name?.capitalized
        self.horarioEstacao = horarioEstacao
        self.morada = morada
        self.acessoMobilidadeReduzida = acessoMobilidadeReduzida
        self.aeroportoNome = aeroportoNome
        self.aeroportoDistancia = aeroportoDistancia
        self.farmaciaNome = farmaciaNome
        self.farmaciaDistancia = farmaciaDistancia
        self.bombeirosNome = bombeirosNome
        self.bombeirosTelefone = bombeirosTelefone
        self.policiaNome = policiaNome
        self.policiaTelefone = policiaTelefone
        self.hospitalNome = hospitalNome
        self.hospitalTelefone = hospitalTelefone
        self.coordenadas = coordenadas
        self.nodeID = nodeID
        self.linha = linha
        self.anoContrucao = anoContrucao
        self.epClassificadoInteresse = epClassificadoInteresse
        self.telefone = telefone
        self.equipamentomobilidadeReduzidaPlataformas = equipamentomobilidadeReduzidaPlataformas
        self.estacionamentoBicicletas = estacionamentoBicicletas
        self.cidadeProxima = cidadeProxima
        self.cidadeProximaDistancia = cidadeProximaDistancia
        self.centroCidadeProximaDistancia = centroCidadeProximaDistancia
        self.pk = pk
    }
}

class TrainStationDetailFotografiasEstacao: Codable {
    let fotografiasEstacao: [FotografiasEstacaoElement]?
    
    enum CodingKeys: String, CodingKey {
        case fotografiasEstacao = "FotografiasEstacao"
    }
    
    init(fotografiasEstacao: [FotografiasEstacaoElement]?) {
        self.fotografiasEstacao = fotografiasEstacao
    }
}

class FotografiasEstacaoElement: Codable {
    let titulo: String?
    let endereco: String?
    
    enum CodingKeys: String, CodingKey {
        case titulo = "Titulo"
        case endereco = "Endereco"
    }
    
    init(titulo: String?, endereco: String?) {
        self.titulo = titulo
        self.endereco = endereco
    }
}

class OperadoresServemEstacao: Codable {
    let operadoresServemEstacao: [SServemEstacao]?
    
    enum CodingKeys: String, CodingKey {
        case operadoresServemEstacao = "OperadoresServemEstacao"
    }
    
    init(operadoresServemEstacao: [SServemEstacao]?) {
        self.operadoresServemEstacao = operadoresServemEstacao
    }
}

class SServemEstacao: Codable {
    let nome: String?
    
    enum CodingKeys: String, CodingKey {
        case nome = "Nome"
    }
    
    init(nome: String?) {
        self.nome = nome
    }
}

class ServicosEquipamentos: Codable {
    let passagemDesnivelada, quantidadeTapetesRolantes, quantidadeEscadasRolantes, quantidadeElevadores: String?
    let telefonesInfoPublico, atm, bilheteira, bilheteiraTelefone: String?
    let horarioFuncionamento, depositoAutobagagem, metro, parqueEstacionamento: String?
    let postoInformacoes, postoPerdidosAchados, salaEspera, sistemaEncPessoasDefVisual: String?
    let autocarros, barcos, cabinesTelefonicas, caixasCorreioCTT: String?
    let instalacoesSanitarias, maquinasVendaBilhetes, informacaoSonora, monitoresPartidasChegadas: String?
    let acessoInternet, rentCar, rentCarTelefone, taxis: String?
    let telefoneTaxis, zonaEstacionamento, quiosqueMultimediaREFER, videoVigilancia: String?
    
    enum CodingKeys: String, CodingKey {
        case passagemDesnivelada = "PassagemDesnivelada"
        case quantidadeTapetesRolantes = "QuantidadeTapetesRolantes"
        case quantidadeEscadasRolantes = "QuantidadeEscadasRolantes"
        case quantidadeElevadores = "QuantidadeElevadores"
        case telefonesInfoPublico = "TelefonesInfoPublico"
        case atm = "Atm"
        case bilheteira = "Bilheteira"
        case bilheteiraTelefone = "BilheteiraTelefone"
        case horarioFuncionamento = "HorarioFuncionamento"
        case depositoAutobagagem = "DepositoAutobagagem"
        case metro = "Metro"
        case parqueEstacionamento = "ParqueEstacionamento"
        case postoInformacoes = "PostoInformacoes"
        case postoPerdidosAchados = "PostoPerdidosAchados"
        case salaEspera = "SalaEspera"
        case sistemaEncPessoasDefVisual = "SistemaEncPessoasDefVisual"
        case autocarros = "Autocarros"
        case barcos = "Barcos"
        case cabinesTelefonicas = "CabinesTelefonicas"
        case caixasCorreioCTT = "CaixasCorreioCTT"
        case instalacoesSanitarias = "InstalacoesSanitarias"
        case maquinasVendaBilhetes = "MaquinasVendaBilhetes"
        case informacaoSonora = "InformacaoSonora"
        case monitoresPartidasChegadas = "MonitoresPartidasChegadas"
        case acessoInternet = "AcessoInternet"
        case rentCar = "RentCar"
        case rentCarTelefone = "RentCarTelefone"
        case taxis = "Taxis"
        case telefoneTaxis = "TelefoneTaxis"
        case zonaEstacionamento = "ZonaEstacionamento"
        case quiosqueMultimediaREFER = "QuiosqueMultimediaREFER"
        case videoVigilancia = "VideoVigilancia"
    }
    
    init(passagemDesnivelada: String?, quantidadeTapetesRolantes: String?, quantidadeEscadasRolantes: String?, quantidadeElevadores: String?, telefonesInfoPublico: String?, atm: String?, bilheteira: String?, bilheteiraTelefone: String?, horarioFuncionamento: String?, depositoAutobagagem: String?, metro: String?, parqueEstacionamento: String?, postoInformacoes: String?, postoPerdidosAchados: String?, salaEspera: String?, sistemaEncPessoasDefVisual: String?, autocarros: String?, barcos: String?, cabinesTelefonicas: String?, caixasCorreioCTT: String?, instalacoesSanitarias: String?, maquinasVendaBilhetes: String?, informacaoSonora: String?, monitoresPartidasChegadas: String?, acessoInternet: String?, rentCar: String?, rentCarTelefone: String?, taxis: String?, telefoneTaxis: String?, zonaEstacionamento: String?, quiosqueMultimediaREFER: String?, videoVigilancia: String?) {
        self.passagemDesnivelada = passagemDesnivelada
        self.quantidadeTapetesRolantes = quantidadeTapetesRolantes
        self.quantidadeEscadasRolantes = quantidadeEscadasRolantes
        self.quantidadeElevadores = quantidadeElevadores
        self.telefonesInfoPublico = telefonesInfoPublico
        self.atm = atm
        self.bilheteira = bilheteira
        self.bilheteiraTelefone = bilheteiraTelefone
        self.horarioFuncionamento = horarioFuncionamento
        self.depositoAutobagagem = depositoAutobagagem
        self.metro = metro
        self.parqueEstacionamento = parqueEstacionamento
        self.postoInformacoes = postoInformacoes
        self.postoPerdidosAchados = postoPerdidosAchados
        self.salaEspera = salaEspera
        self.sistemaEncPessoasDefVisual = sistemaEncPessoasDefVisual
        self.autocarros = autocarros
        self.barcos = barcos
        self.cabinesTelefonicas = cabinesTelefonicas
        self.caixasCorreioCTT = caixasCorreioCTT
        self.instalacoesSanitarias = instalacoesSanitarias
        self.maquinasVendaBilhetes = maquinasVendaBilhetes
        self.informacaoSonora = informacaoSonora
        self.monitoresPartidasChegadas = monitoresPartidasChegadas
        self.acessoInternet = acessoInternet
        self.rentCar = rentCar
        self.rentCarTelefone = rentCarTelefone
        self.taxis = taxis
        self.telefoneTaxis = telefoneTaxis
        self.zonaEstacionamento = zonaEstacionamento
        self.quiosqueMultimediaREFER = quiosqueMultimediaREFER
        self.videoVigilancia = videoVigilancia
    }
}

class TiposDeComboiosServemEstacao: Codable {
    let tiposDeComboiosServemEstacao: [SServemEstacao]?
    
    enum CodingKeys: String, CodingKey {
        case tiposDeComboiosServemEstacao = "TiposDeComboiosServemEstacao"
    }
    
    init(tiposDeComboiosServemEstacao: [SServemEstacao]?) {
        self.tiposDeComboiosServemEstacao = tiposDeComboiosServemEstacao
    }
}

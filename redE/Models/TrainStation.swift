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

class TrainStation: NSObject, Codable {
    var name: String?
//    let servicosEquipamentos: ServicosEquipamentos?
//    let fotografiasEstacao: TrainStationDetailFotografiasEstacao?
//    let tiposDeComboiosServemEstacao: TiposDeComboiosServemEstacao?
//    let operadoresServemEstacao: OperadoresServemEstacao?
//    var descricaoEstacao,
    var horarioEstacao, morada, acessoMobilidadeReduzida: String?
    var aeroportoNome, aeroportoDistancia, farmaciaNome, farmaciaDistancia: String?
    var bombeirosNome, bombeirosTelefone, policiaNome, policiaTelefone: String?
    var hospitalNome, hospitalTelefone, coordenadas, nodeID: String?
    var linha, anoContrucao, epClassificadoInteresse, telefone: String?
    var equipamentomobilidadeReduzidaPlataformas, estacionamentoBicicletas, cidadeProxima, cidadeProximaDistancia: String?
    var centroCidadeProximaDistancia, pk: String?
    
    var mapCoordinates: CLLocationCoordinate2D {
        var coordinates = CLLocationCoordinate2D()
        var coords = coordenadas!.components(separatedBy: " ; ")
        let latString = coords[0].components(separatedBy: "lat=")[1]
        let longString = coords[1].components(separatedBy: "long=")[1]
        coordinates = CLLocationCoordinate2D(
            latitude: Double(latString)!,
            longitude: Double(longString)!)
        return coordinates
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "Nome"
//        case servicosEquipamentos = "ServicosEquipamentos"
//        case fotografiasEstacao = "FotografiasEstacao"
//        case tiposDeComboiosServemEstacao
//        case operadoresServemEstacao = "OperadoresServemEstacao"
//        case descricaoEstacao = "DescricaoEstacao"
        case horarioEstacao = "HorarioEstacao"
        case morada = "Morada"
        case acessoMobilidadeReduzida = "AcessoMobilidadeReduzida"
        case aeroportoNome = "AeroportoNome"
        case aeroportoDistancia = "AeroportoDistancia"
        case farmaciaNome = "FarmaciaNome"
        case farmaciaDistancia = "FarmaciaDistancia"
        case bombeirosNome = "BombeirosNome"
        case bombeirosTelefone = "BombeirosTelefone"
        case policiaNome = "PoliciaNome"
        case policiaTelefone = "PoliciaTelefone"
        case hospitalNome = "HospitalNome"
        case hospitalTelefone = "HospitalTelefone"
        case coordenadas = "Coordenadas"
        case nodeID = "NodeID"
        case linha = "Linha"
        case anoContrucao = "AnoContrucao"
        case epClassificadoInteresse = "EPClassificadoInteresse"
        case telefone = "Telefone"
        case equipamentomobilidadeReduzidaPlataformas = "EquipamentomobilidadeReduzidaPlataformas"
        case estacionamentoBicicletas = "EstacionamentoBicicletas"
        case cidadeProxima = "CidadeProxima"
        case cidadeProximaDistancia = "CidadeProximaDistancia"
        case centroCidadeProximaDistancia = "CentroCidadeProximaDistancia"
        case pk = "PK"
    }
    init(name: String?, horarioEstacao: String?, morada: String?, acessoMobilidadeReduzida: String?, aeroportoNome: String?, aeroportoDistancia: String?, farmaciaNome: String?, farmaciaDistancia: String?, bombeirosNome: String?, bombeirosTelefone: String?, policiaNome: String?, policiaTelefone: String?, hospitalNome: String?, hospitalTelefone: String?, coordenadas: String?, nodeID: String?, linha: String?, anoContrucao: String?, epClassificadoInteresse: String?, telefone: String?, equipamentomobilidadeReduzidaPlataformas: String?, estacionamentoBicicletas: String?, cidadeProxima: String?, cidadeProximaDistancia: String?, centroCidadeProximaDistancia: String?, pk: String?) {
        self.name = name?.capitalized
//        self.descricaoEstacao = descricaoEstacao
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

//
//  CellSchedule.swift
//  redE
//
//  Created by Joao Pires on 12/21/18.
//  Copyright © 2018 Joao Pires. All rights reserved.
//

import UIKit

class CellSchedule: UITableViewCell {
    @IBOutlet weak var labelOrigin: UILabel!
    @IBOutlet weak var labelDestiny: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var labelDeparture: UILabel!
    @IBOutlet weak var viewStatus: UIView!
    @IBOutlet weak var iconStatus: UIImageView!
    
    static let identifier = "CellSchedule"
    
    private var schedule = HorarioDetalhe()
    
    func setup(with sentSchedule: HorarioDetalhe) {
        
        self.schedule = sentSchedule
        self.labelOrigin.text = schedule.estacaoOrigem?.nome?.capitalized ?? ""
        self.labelDestiny.text = sentSchedule.estacaoDestino?.nome?.capitalized ?? ""
        self.labelStatus.text = sentSchedule.estadoComboio?.descricao?.capitalized ?? ""
        let departureTime = sentSchedule.horaPartida?.components(separatedBy: " ")[1] ?? ""
        self.labelDeparture.text = "Saida da Estação: \(departureTime)"
        setupViews()
    }
    
    private func setupViews() {
        
        guard let status = schedule.estadoComboio?.descricao?.capitalized else { return }
        if status == "À Tabela" {
            viewStatus.backgroundColor = UIColor.green
            iconStatus.tintColor = UIColor.green
        }
        else if status.contains("Atrasado") {
            viewStatus.backgroundColor = UIColor.orange
            iconStatus.tintColor = UIColor.orange
        }
        else {
            viewStatus.backgroundColor = UIColor.red
            iconStatus.tintColor = UIColor.red
        }
    }
}

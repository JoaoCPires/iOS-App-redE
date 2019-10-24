//
//  ScheduleCard.swift
//  redE
//
//  Created by Joao Pires on 24/10/2019.
//  Copyright © 2019 Joao Pires. All rights reserved.
//

import SwiftUI

struct ScheduleCard: View {
    var schedule: ScheduleDetail
    var type: ScheduleType

    var body: some View {

        HStack(alignment:.center) {
            CircleSystemImage(imageName: icon(), imageSize: 32, backgroundColor: color(), color: .white)
                .padding()
            VStack(alignment: .leading) {
                Text(schedule.nameFor(type))
                    .font(.headline)

                Text(schedule.estadoComboio?.nome ?? "Sem Info" )//.status.description)
                    .font(.caption)

                Text(schedule.timeFor(type))
                    .font(.caption)
            }
            Spacer()
        }
    }

    private func icon() -> String {

        switch schedule.status {
        case .onTime: return "chevron.right.2"
        case .delayed: return "chevron.compact.right"
        case .canceled: return "xmark"
        }
    }

    private func color() -> UIColor {
        switch schedule.status {
        case .onTime: return .green
        case .delayed: return .orange
        case .canceled: return .red
        }

    }
}

struct ScheduleCard_Previews: PreviewProvider {
    static var previews: some View {
        let origen = Comboio(id: 9430007, nome: "LISBOA-APOLÓNIA")
        let destino = Comboio(id: 9449007, nome: "GUARDA")
        let status = EstadoComboio(id: 2, nome: "À tabela", descricao: "À tabela")

        let schedule = ScheduleDetail(id: 513, nome: "IC", horaChegada: "24-10-2019 12:30:00", horaPartida: "24-10-2019 12:30:00", comboio: nil, estacaoOrigem: origen, estacaoDestino: destino, operador: nil, estadoComboio: status)
        return ScheduleCard(schedule: schedule, type: .arrival)
         .previewLayout(.fixed(width: 335, height: 82))
    }
}

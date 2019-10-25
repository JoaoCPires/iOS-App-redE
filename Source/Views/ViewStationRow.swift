//
//  ViewStationRow.swift
//  redE
//
//  Created by Joao Pires on 25/10/2019.
//  Copyright © 2019 Joao Pires. All rights reserved.
//

import SwiftUI

struct ViewStationRow: View {

    var station: BaseStation

    var body: some View {

        VStack(alignment: .leading, spacing: 4) {

            HStack {
                Text(station.name.capitalized(with: Locale(identifier: "pt")))
                    .font(.callout)

                Circle()
                    .frame(width: 10, height: 10, alignment: .trailing)
                    .foregroundColor(colorForSchedule())

                Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .padding(.bottom, 10)
            HStack {
                ForEach(station.ameneties, id: \.self) { amenety in

                    CircleImage(imageName: amenety.imageName)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 40, alignment: .leading)
            .padding(.bottom, 4)
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 80, maxHeight: 80, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(10, antialiased: true)
        .shadow(color: Color(.lightGray), radius: 5, x: 2, y: 2)
    }


    // MARK: - Methods
    private func colorForSchedule() -> Color {

        var result = UIColor(named: "colorOnTime")!
        var isDelayed = false
        var isCanceled = false
        for schedule in station.arrivingSchedules?.scheduleDetail ?? [] {

            if schedule.estadoComboio?.nome?.contains("Atrasado") ?? false { isDelayed = true }
            if schedule.estadoComboio?.nome?.contains("Cancelado") ?? false { isCanceled = true }
            if schedule.estadoComboio?.nome?.contains("Suprimido") ?? false { isCanceled = true }
        }
        if isCanceled { result = UIColor(named: "colorCanceled")! }
        else if isDelayed { result = UIColor(named: "colorDelayed")! }

        return Color(result)
    }

    private func amenetiesForTrainStation() -> [Image] {

        let result = [Image]()
        return result
    }
}
struct ViewStationRow_Previews: PreviewProvider {
    static var previews: some View {
        ViewStationRow(station: PreviewObject.station)
    }
}

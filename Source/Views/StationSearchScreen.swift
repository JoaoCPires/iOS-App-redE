//
//  StationSearchScreen.swift
//  redE
//
//  Created by Joao Pires on 24/10/2019.
//  Copyright © 2019 Joao Pires. All rights reserved.
//

import SwiftUI

struct StationSearchScreen: View, TrainStationsManagerDelegate {

    func trainStationManager(didSend trainsStations: [BaseStation]) {

        stations = trainsStations
    }

    private let title = "Pesquisa"

    @State var stations = [BaseStation]()
    @State var query = String()

    var addToFavorites: Bool = false

    var body: some View {

        VStack {

            HStack {

                Image(systemName: "magnifyingglass")

                TextField("search", text: $query, onCommit: { TrainStationManager.getStations(withName: self.query, to: self) })
                    .foregroundColor(.primary)
                    .keyboardType(.alphabet)
                    .disableAutocorrection(true)

                Button(action: { self.query = "" }) { Image(systemName: "xmark.circle.fill").opacity(query == "" ? 0 : 1) }
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
            .padding(.leading, 20)
            .padding(.trailing, 20)

            ScrollView {

                ForEach(stations) { station in

                    NavigationLink(destination: StationScreen(station: station), label: {

                        ViewStationRow(station: station)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 77, maxHeight: 77, alignment: .leading)
                            .padding(.top, 8)
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                            .padding(.bottom, 16)
                    })
                    .onTapGesture { UIImpactFeedbackGenerator(style: .heavy).impactOccurred() }

                    Spacer()
                }
            }
        }
        .navigationBarTitle(title)
    }
}

struct StationSearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        StationSearchScreen()
    }
}

struct ViewStationRow: View {

    var station: BaseStation

    var body: some View {

        VStack(alignment: .leading) {

            HStack {

                Text(station.name.capitalized(with: Locale(identifier: "pt")))
                    .font(.callout)

                Circle()
                    .frame(width: 10, height: 10, alignment: .trailing)
                    .foregroundColor(colorForSchedule())

                Spacer()

            }


            HStack {

                if station.details?.hospitalNome != "" { CircleImage(imageName: "IconHospital") }
                if station.details?.policiaNome != "" { CircleImage(imageName: "IconShield") }
                if station.details?.bombeirosNome != "" { CircleImage(imageName: "IconFire") }
                if station.details?.farmaciaNome != "" { CircleImage(imageName: "IconPharmacy") }
                if station.details?.acessoMobilidadeReduzida != "Não" || station.details?.acessoMobilidadeReduzida != ""  { CircleImage(imageName: "IconAccessibility") }
                if station.details?.estacionamentoBicicletas == "Sim" { CircleImage(imageName: "IconBicycle") }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 77, maxHeight: 77, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(10, antialiased: true)
        .shadow(color: Color(.lightGray), radius: 5, x: 2, y: 2)
    }


    // MARK: - Methods
    private func colorForSchedule() -> Color {

        var result = Color.green
        var isDelayed = false
        var isCanceled = false
        for schedule in station.arrivingSchedules?.scheduleDetail ?? [] {

            if schedule.estadoComboio?.nome?.contains("Atrasado") ?? false { isDelayed = true }
            if schedule.estadoComboio?.nome?.contains("Cancelado") ?? false { isCanceled = true }
            if schedule.estadoComboio?.nome?.contains("Suprimido") ?? false { isCanceled = true }
        }
        if isCanceled { result = .red }
        else if isDelayed { result = .yellow }

        return result
    }

    private func amenetiesForTrainStation() -> [Image] {

        let result = [Image]()
        return result
    }
}

//
//  ViewMain.swift
//  redE
//
//  Created by Joao Pires on 12/10/2019.
//  Copyright © 2019 Joao Pires. All rights reserved.
//

import SwiftUI

struct ViewMain_Previews: PreviewProvider {
    static var previews: some View {
        ViewMain()
    }
}


struct ViewMain: View, TrainStationManagerDelegate {

    private var title = "Estações"

    var body: some View {

//        NavigationView {
//            ScrollView {
//                ForEach(savedStations) { station in
//
//                    ViewStationRow(station: station)
//                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 77, maxHeight: 77, alignment: .leading)
//                        .padding(.top, 8)
//                        .padding(.leading, 20)
//                        .padding(.trailing, 20)
//                        .padding(.bottom, 16)
//                }
//                .navigationBarTitle(title)
//                .navigationBarItems(trailing:
//                    NavigationLink(destination: SearchView(stations: [], addToFavorites: true), label: {
//
//                        Image(systemName: "plus")
//                            .frame(width: 42, height: 42, alignment: .center)
//                    })
//                )
//
//            }
//            .onAppear(perform: {TrainStationManager.getStation(withName: "Apo", to: self)})
//        }
        Text("Main")
    }

    func trainStationManager(didSend trainsStations: [BaseStation]) {

    }

}

struct ViewStationRow: View {

    @Binding var station: BaseStation

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
        for schedule in station.schedules?.scheduleDetail ?? [] {

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

struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

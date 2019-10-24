//
//  StationView.swift
//  redE
//
//  Created by Joao Pires on 23/10/2019.
//  Copyright © 2019 Joao Pires. All rights reserved.
//

import SwiftUI
import MapKit

struct StationView: View {

    @State var station: BaseStation
    @State private var selectedSchedule = 0

    var body: some View {

        ZStack {

            VStack {

                MapView(coordenates: station.mapCoordinates)
                    .frame(height: 215)
                    .edgesIgnoringSafeArea(.top)

                Spacer()
            }

            ScrollView {

                VStack {

                    Spacer().frame(height: 215)

                    VStack(alignment: .leading) {

                        VStack(alignment: .leading) {

                            Text(station.stationName)
                                .font(.title)

                            Text(station.stationLine)
                                .font(.caption)
                                .padding(.top, 4)
                                .padding(.bottom, 4)

                            Text(station.stationAddress)
                                .lineLimit(2)
                                .font(.subheadline)

                            if station.hasAmeneties {
                                AmenetiesView(ameneties: station.ameneties)
                                    .padding(.top, 4)
                                    .padding(.bottom, 4)
                            }

                        }
                        .padding(.leading, 20)
                        .padding(.trailing, 20)

                        if station.hasContacts {
                            Text("Contacts")
                                .font(.callout)
                                .padding(.leading, 20)

                            ScrollView(.horizontal, showsIndicators: false) {

                                HStack{
                                    Spacer().frame(width: 20, height: 20)
                                    ForEach(0..<station.contacts.count) { index in

                                        ContactCard(contactInfo: self.station.contacts[index])
                                            .frame(minWidth: AppDimensions.screenWidth - 60, maxWidth: AppDimensions.screenWidth - 60, minHeight: AppDimensions.screenWidth - 60, maxHeight: .infinity)
                                            .clipped()
                                            .shadow(color: Color(.lightGray), radius: 2, x: 2, y: 2)
                                    }

                                    Spacer().frame(width: 20, height: 20)
                                }
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 80)

                            }
                            Spacer()

                        }

                        Picker(selection: $selectedSchedule, label: Text("What is your favorite color?")) {
                            Text("Partidas").tag(0)
                            Text("Chegadas").tag(1)
                        }
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                        .pickerStyle(SegmentedPickerStyle())

                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                    .background(Color(.systemBackground))
                }
                .edgesIgnoringSafeArea(.top)
            }
            .edgesIgnoringSafeArea(.top)

        }
    }
}

struct StationView_Previews: PreviewProvider {
    static var previews: some View {

        let details = TrainStation(
            name: "LISBOA-APOLÓNIA",
            horarioEstacao: nil,
            morada: "Largo dos Caminhos de Ferro - Estação de Santa Apolónia, Lisboa",
            acessoMobilidadeReduzida: "Sim",
            aeroportoNome: nil,
            aeroportoDistancia: nil,
            farmaciaNome: nil,
            farmaciaDistancia: nil,
            bombeirosNome: "Regimento Sapadores Bombeiros de Lisboa",
            bombeirosTelefone: "808 215 215",
            policiaNome: "4ª Esquadra de Segurança a Transportes Públicos",
            policiaTelefone: "218 946 046",
            hospitalNome: "Hospital de Santa Maria",
            hospitalTelefone: "217 805 000",
            coordenadas: "lat=41.547843270000001 ; long=-8.4346801609999993",
            nodeID: nil,
            linha: "Linha de Sintra",
            anoContrucao: nil,
            epClassificadoInteresse: nil,
            telefone: "218 841 000",
            equipamentomobilidadeReduzidaPlataformas: nil,
            estacionamentoBicicletas: "Sim",
            cidadeProxima: nil,
            cidadeProximaDistancia: nil,
            centroCidadeProximaDistancia: nil,
            pk: nil)
        let station = BaseStation(id: 9430007, name: "LISBOA-APOLÓNIA", details: details, schedules: nil)

        return StationView(station: station)
    }
}

struct MapView: UIViewRepresentable {

    var coordenates: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ view: MKMapView, context: Context) {

        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let region = MKCoordinateRegion(center: coordenates, span: span)
        view.setRegion(region, animated: true)
        view.isUserInteractionEnabled = false
    }
}

struct AmenetiesView: View {

    var ameneties: [StationAmeneties]

    var body: some View {

        HStack {

            ForEach(ameneties, id: \.self) { amenety in

                CircleImage(imageName: amenety.imageName, imageSize: 32)
            }
        }
    }
}

struct CircleImage: View {

    var imageName: String
    var imageSize: CGFloat = 32
    private var iconSize: CGFloat {
        imageSize * 0.60
    }
    var body: some View {

        ZStack {

            Circle()
                .foregroundColor(Color.blue)
                .frame(width: imageSize, height: imageSize, alignment: .center)

            Image(imageName)
                .resizable()
                .renderingMode(.template)
                .frame(width: iconSize, height: iconSize, alignment: .center)
                .aspectRatio(contentMode: .fill)
                .foregroundColor(.white)
        }
    }
}

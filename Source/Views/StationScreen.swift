//
//  StationScreen.swift
//  redE
//
//  Created by Joao Pires on 23/10/2019.
//  Copyright © 2019 Joao Pires. All rights reserved.
//

import SwiftUI
import MapKit

struct StationScreen: View, TrainStationManagerDelegate {

    func trainStationManager(didSend trainsStation: BaseStation) {

        station = trainsStation
        selectedSchedule = 0
    }


    @State var station: BaseStation
    @State private var selectedSchedule = 1

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

                        HeaderCard(station: $station)

                        if station.hasContacts {

                            Text("Contacts")
                                .font(.callout)
                                .padding(.leading, 20)

                            ScrollView(.horizontal, showsIndicators: false) {

                                HStack{

                                    Spacer().frame(width: 20, height: 20)

                                    ForEach(station.contacts) { contact in

                                        ContactCard(contactInfo: contact)
                                            .frame(minWidth: AppDimensions.screenWidth - 60, maxWidth: AppDimensions.screenWidth - 60, minHeight: AppDimensions.screenWidth - 60, maxHeight: .infinity)
                                            .shadow(color: Color(.systemGray), radius: 4, x: 2, y: 2)
                                            .onTapGesture {

                                                guard let number = URL(string: "tel://" + contact.callingNumber) else { return }
                                                UIApplication.shared.open(number)
                                        }
                                    }

                                    Spacer().frame(width: 20, height: 20)
                                }
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 80)
                            }

                            Spacer()
                        }

                        Picker(selection: $selectedSchedule, label: Text("Arrivals or Departures")) {
                            Text("Partidas").tag(0)
                            Text("Chegadas").tag(1)
                        }
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                        .pickerStyle(SegmentedPickerStyle())

                        VStack{

                            ForEach(selectedSchedule == 0 ? station.departingScheduleDetails: station.arrivingScheduleDetails) { index in

                                ScheduleCard(schedule: index, type: self.selectedSchedule == 0 ? .departure : .arrival)
                                    .background(Color(.systemBackground))
                                    .cornerRadius(10)
                                    .shadow(color: Color(.systemGray), radius: 4, x: 2, y: 2)
                            }
                        }
                        .padding(.top, 8)
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                    .background(Color(.systemBackground))
                }
                .edgesIgnoringSafeArea(.top)
            }
            .edgesIgnoringSafeArea(.top)
        }
        .onAppear {

            TrainStationManager.getStationDetails(for: self.station, to: self)
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

        let origen = Comboio(id: 9430007, nome: "LISBOA-APOLÓNIA")
        let destino = Comboio(id: 9449007, nome: "GUARDA")
        let status = EstadoComboio(id: 2, nome: "À tabela", descricao: "À tabela")

        let scheduleDetail = ScheduleDetail(id: 513, nome: "IC", horaChegada: "24-10-2019 12:30:00", horaPartida: "24-10-2019 12:30:00", comboio: nil, estacaoOrigem: origen, estacaoDestino: destino, operador: nil, estadoComboio: status)

        let schedule = Schedule()
        schedule.scheduleDetail = [scheduleDetail,scheduleDetail,scheduleDetail,scheduleDetail,scheduleDetail,scheduleDetail]

        let station = BaseStation(id: 9430007, name: "LISBOA-APOLÓNIA", details: details, arrivingSchedules: schedule, departingSchedules: schedule)

        return StationScreen(station: station)
    }
}

struct MapView: UIViewRepresentable {

    var coordenates: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ view: MKMapView, context: Context) {

        let span = MKCoordinateSpan(latitudeDelta: 0.0025, longitudeDelta: 0.0025)
        let region = MKCoordinateRegion(center: coordenates, span: span)
        view.setRegion(region, animated: true)
        view.isUserInteractionEnabled = false

        let newPin = MKPointAnnotation()
        newPin.coordinate = coordenates
        view.addAnnotation(newPin)
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

struct HeaderCard: View {

    @Binding var station: BaseStation

    var body: some View {
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
    }
}

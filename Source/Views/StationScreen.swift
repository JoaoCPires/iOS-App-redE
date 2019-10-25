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
    @State var station: BaseStation
    @State private var selectedSchedule = 1
    @State private var hideHeader = true
    @State private var title = ""

    var body: some View {
        
        ScrollView {

            VStack {
                GeometryReader { geometry -> MapView in

                    let coordenate = geometry.frame(in: .global).maxY
                    self.title = coordenate < 20 ? self.station.stationName : ""
                    return MapView(coordenates: self.station.mapCoordinates)
                }
                .frame(height: 215)
                .edgesIgnoringSafeArea(.top)

                VStack(alignment: .leading) {

                    HeaderCard(station: $station)

                    if station.hasContacts {

                        Text("label.contacts".localized)
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

                    Picker(selection: $selectedSchedule, label: Text("accessibilty.arrivals.departures".localized)) {
                        Text("label.departures".localized).tag(0)
                        Text("label.arrivals".localized).tag(1)
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
        }
        .navigationBarTitle(Text(title), displayMode: .inline)
        .onAppear {

            TrainStationManager.getStationDetails(for: self.station, to: self)
        }
    }

    func trainStationManager(didSend trainsStation: BaseStation) {

        station = trainsStation
        selectedSchedule = 0
    }

}

struct StationView_Previews: PreviewProvider {
    static var previews: some View {

        return StationScreen(station: PreviewObject.station)
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

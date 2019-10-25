//
//  ViewMain.swift
//  redE
//
//  Created by Joao Pires on 12/10/2019.
//  Copyright © 2019 Joao Pires. All rights reserved.
//

import SwiftUI
import KeirmotUtils

struct ViewMain_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}


struct HomeScreen: View, TrainStationsManagerDelegate {
    @State var savedStations: [BaseStation] = [BaseStation]()
    @State private var hasSavedStations = false

    private var title = "screen.title.stations".localized

    var body: some View {

        NavigationView {
            if hasSavedStations {
                ScrollView {
                    ForEach(savedStations) { station in
                        NavigationLink(destination: StationScreen(station: station), label: {

                            ViewStationRow(station: station)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 77, maxHeight: 77, alignment: .leading)
                                .padding(.top, 8)
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                                .padding(.bottom, 16)
                        })
                    }
                    .navigationBarTitle(title)
                    .navigationBarItems(trailing:
                        NavigationLink(destination: StationSearchScreen(stations: []), label: {

                            Image(systemName: "magnifyingglass")
                                .frame(width: 42, height: 42, alignment: .center)
                        })
                    )
                }
                .onAppear {
                    DispatchQueue.global().async {

                        TrainStationManager.getSavedStations(to: self)
                    }
                }
            }
            if !hasSavedStations {
                Text("label.add.stations".localized)
                    .foregroundColor(Color.gray)
                    .navigationBarTitle(title)
                    .navigationBarItems(trailing:
                        NavigationLink(destination: StationSearchScreen(stations: []), label: {

                            Image(systemName: "magnifyingglass")
                                .frame(width: 42, height: 42, alignment: .center)
                        })
                )

                    .onAppear {
                        DispatchQueue.global().async {

                            TrainStationManager.getSavedStations(to: self)
                        }
                }
            }
        }
    }

    // MARK: - Delegates
    func trainStationManager(didSend trainsStations: [BaseStation]) {

        hasSavedStations = trainsStations.count > 0
        savedStations = trainsStations
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

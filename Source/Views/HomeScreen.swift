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
        HomeScreen()
    }
}


struct HomeScreen: View, TrainStationsManagerDelegate {

    private var title = "screen.title.stations".localized

    @State var savedStations: [BaseStation] = [BaseStation]()

    var body: some View {

        NavigationView {
            ScrollView {
                ForEach(savedStations) { station in

                    ViewStationRow(station: station)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 77, maxHeight: 77, alignment: .leading)
                        .padding(.top, 8)
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                        .padding(.bottom, 16)
                }
                .navigationBarTitle(title)
                .navigationBarItems(trailing:
                    NavigationLink(destination: StationSearchScreen(stations: [], addToFavorites: true), label: {

                        Image(systemName: "plus")
                            .frame(width: 42, height: 42, alignment: .center)
                    })
                )
            }
        }
        .onAppear {
            TrainStationManager.getSavedStations(to: self)
        }
    }

    // MARK: - Delegates
    func trainStationManager(didSend trainsStations: [BaseStation]) {

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

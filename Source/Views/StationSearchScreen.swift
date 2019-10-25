//
//  StationSearchScreen.swift
//  redE
//
//  Created by Joao Pires on 24/10/2019.
//  Copyright © 2019 Joao Pires. All rights reserved.
//

import SwiftUI

struct StationSearchScreen: View, TrainStationsManagerDelegate {
    @State var stations = [BaseStation]()
    @State var query = String()
    @State var isSearching = false

    private let title = "screen.title.search".localized

    var body: some View {

        VStack {

            HStack {

                Image(systemName: "magnifyingglass")

                TextField("placeholder.search".localized, text: $query, onCommit: {

                    self.stations = []
                    self.isSearching = true
                    TrainStationManager.getStations(withName: self.query, to: self)
                })
                    .foregroundColor(.primary)
                    .keyboardType(.alphabet)
                    .disableAutocorrection(true)

                Button(action: {

                    self.isSearching = false
                    self.query = ""
                }) { Image(systemName: "xmark.circle.fill").opacity(query == "" ? 0 : 0.85) }
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
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 80, maxHeight: 80, alignment: .leading)
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
        .navigationBarItems(trailing:
            ActivityIndicator(isAnimating: $isSearching, style: .medium)
                .opacity(isSearching ? 1 : 0 )
        )

    }

    func trainStationManager(didSend trainsStations: [BaseStation]) {

        if isSearching {

            stations = trainsStations
            isSearching = false
        }
    }

}

struct StationSearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        StationSearchScreen()
    }
}

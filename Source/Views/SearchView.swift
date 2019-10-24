//
//  SearchView.swift
//  redE
//
//  Created by Joao Pires on 22/10/2019.
//  Copyright © 2019 Joao Pires. All rights reserved.
//

import SwiftUI

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

struct SearchView: View {

    private let title = "Pesquisa"

    @State var stations = [BaseStation]()
    @State var query = String()

    var addToFavorites: Bool = false

    var body: some View {

        Text("Teste")
//        VStack {
//
//            HStack {
//                Image(systemName: "magnifyingglass")
//                TextField("search", text: $query, onCommit: { TrainStationManager.getStation(withName: self.query, to: self) })
//                    .foregroundColor(.primary)
//                    .keyboardType(.alphabet)
//                    .disableAutocorrection(true)
//                Button(action: { self.query = "" }) { Image(systemName: "xmark.circle.fill").opacity(query == "" ? 0 : 1) }
//            }
//            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
//            .foregroundColor(.secondary)
//            .background(Color(.secondarySystemBackground))
//            .cornerRadius(10.0)
//            .padding(.leading, 20)
//            .padding(.trailing, 20)
//            ScrollView {
//                ForEach(stations) { station in
//                    NavigationLink(destination: StationView(station: station.details), label: {
//
//                        ViewStationRow(station: station)
//                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 77, maxHeight: 77, alignment: .leading)
//                            .padding(.top, 8)
//                            .padding(.leading, 20)
//                            .padding(.trailing, 20)
//                            .padding(.bottom, 16)
//                    })
//                }
//            }
//        }
//        .navigationBarTitle(title)
    }
}

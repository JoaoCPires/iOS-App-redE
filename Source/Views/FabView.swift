//
//  FabView.swift
//  pokeapp
//
//  Created by Joao Pires on 22/10/2019.
//  Copyright © 2019 Joao Pires. All rights reserved.
//

import SwiftUI

struct FabView: View {
    
    var action: AppAction

    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                Button(action: { self.action() }, label: { Image(systemName: "plus") })
                    .foregroundColor(Color(.label))
                    .frame(width: AppDimensions.fabSize, height: AppDimensions.fabSize, alignment: .center)
                    .background(Color(.white))
                    .cornerRadius(AppDimensions.fabCornerRadius, antialiased: true)
                    .shadow(color: Color(.lightGray), radius: 5, x: 2, y: 2)
                    .padding(32)

            }
        }
    }
}

struct FabView_Previews: PreviewProvider {

    static var previews: some View {

        FabView(action: {})
    }
}

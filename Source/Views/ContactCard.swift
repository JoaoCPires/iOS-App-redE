//
//  ContactCard.swift
//  redE
//
//  Created by Joao Pires on 24/10/2019.
//  Copyright © 2019 Joao Pires. All rights reserved.
//

import SwiftUI

struct ContactCard: View {

    var contactInfo: Contact

    var body: some View {

        HStack {

            CircleImage(imageName: contactInfo.imageName)
                .padding()

            VStack(alignment: .leading) {

                Text(contactInfo.title.capitalized(with: Locale(identifier: "pt")))
                    .font(.headline)
                    .lineLimit(2)

                Text(contactInfo.phoneNumber)
                    .font(.caption)
            }

            Spacer()

            CircleSystemImage(imageName: "phone.arrow.up.right", backgroundColor: .white, color: .lightGray)
                .padding()
        }
        .background(Color(.systemBackground))
        .cornerRadius(10)
    }
}

struct ContactCard_Previews: PreviewProvider {

    static var previews: some View {

        ContactCard(contactInfo: Contact(imageName: "TrainGlyph", title: "LISBOA-APOLÓNIA", phoneNumber: "218 841 000"))
            .previewLayout(.fixed(width: 335, height: 82))
    }
}

struct CircleSystemImage: View {

    var imageName: String
    var imageSize: CGFloat = 32
    var backgroundColor: UIColor = .blue
    var color: UIColor = .white
    private var iconSize: CGFloat {
        imageSize * 0.60
    }
    var body: some View {

        ZStack {

            Circle()
                .foregroundColor(Color(backgroundColor))
                .frame(width: imageSize, height: imageSize, alignment: .center)

            Image(systemName: imageName)
                .resizable()
                .renderingMode(.template)
                .frame(width: iconSize, height: iconSize, alignment: .center)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color(color))
        }
    }
}

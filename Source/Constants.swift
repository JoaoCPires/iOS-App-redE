//
//  Constants.swift
//  pokeapp
//
//  Created by Joao Pires on 20/10/2019.
//  Copyright © 2019 Joao Pires. All rights reserved.
//

import UIKit

typealias AppDimensions = Constants.Dimensions
typealias AppColors = Constants.Colors
typealias AppAction = ()->()

struct Constants {

    struct Dimensions {

        static var screenWidth: CGFloat {

            UIScreen.main.bounds.width
        }

        static var fabSize: CGFloat = 50

        static var fabCornerRadius: CGFloat = fabSize / 2

    }

    struct Colors {
        static var colorCanceled = UIColor(named: "colorCanceled")!
        static var colorDelayed = UIColor(named: "colorDelayed")!
        static var colorOnTime = UIColor(named: "colorOnTime")!
    }

    static func nowString() -> String {

        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss"
        let result = formatter.string(from: date)
        return result
    }

    static func todayString() -> String {

        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd'T'23:59:59"
        let result = formatter.string(from: date)
        return result
    }

}

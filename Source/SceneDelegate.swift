//
//  SceneDelegate.swift
//  redE
//
//  Created by Joao Pires on 12/10/2019.
//  Copyright © 2019 Joao Pires. All rights reserved.
//

import UIKit
import SwiftUI
import MapKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

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
        let station = BaseStation(id: 9430007, name: "LISBOA-APOLÓNIA", details: details, arrivingSchedules: nil, departingSchedules: nil)



        // Create the SwiftUI view that provides the window contents.
        let contentView = StationView(station: station)
        // ViewMap(coordinate: CLLocationCoordinate2D(latitude: 39.5, longitude: -8.0))

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}


//
//  JumpeakApp.swift
//  Jumpeak
//
//  Created by Денис Большачков on 10.04.2023.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        FirebaseConfiguration.shared.setLoggerLevel(.debug)
        return true
    }
}


@main
struct WasteFutureApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//    @StateObject var sessionService: SessionService = ApplicationAssemby.defaultContainer.resolve(SessionService.self)!

    var body: some Scene {
        WindowGroup {
            StartView()
        }
    }
}

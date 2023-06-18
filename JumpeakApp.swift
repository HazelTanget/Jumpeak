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
    @StateObject var sessionService: SessionService = ApplicationAssemby.defaultContainer.resolve(SessionService.self)!
    @State private var selection: Int?

    var body: some Scene {
        WindowGroup {
            switch sessionService.state {
            case .loggedIn:
                MainView()
            case .loggedOut:
                CommonInfoView(text: "Первый шаг сделан, теперь покажем твои работы ", descriptionText: "К проектам можно добавить фотографии или фрагменты кода. А ещё можно добавить ссылку на проект на других площадках") {
                    HStack {
                        NavigationLink (destination: LoginView().navigationBarBackButtonHidden(true), tag: 1, selection: $selection, label: {
                            AccentButton(text: "Перейти в меню создания резюме",
                                         foregroundColor: Asset.Colors.thirdFontColor.swiftUIColor,
                                         backgroundColor: Asset.Colors.background.swiftUIColor.opacity(0.2)) {
                                selection = 1
                            }
                        })

                        NavigationLink (destination: SecondStepView().navigationBarBackButtonHidden(true), tag: 2, selection: $selection, label: {
                            AccentButton(text: "Загрузить работы!",
                                         foregroundColor: Asset.Colors.mainFontColor.swiftUIColor,
                                         backgroundColor: Asset.Colors.background.swiftUIColor) {
                                selection = 2
                            }
                        })
                    }
                    .padding(.horizontal, 8)
                    .padding(.bottom, 51)
                }

//                CommonInfoView(text: Strings.helloText, descriptionText: Strings.doYouUseApp, content: {
//                    HStack {
//                        NavigationLink (destination: LoginView().navigationBarBackButtonHidden(true), tag: 1, selection: $selection, label: {
//                            AccentButton(text: Strings.enter,
//                                         foregroundColor: Asset.Colors.thirdFontColor.swiftUIColor,
//                                         backgroundColor: Asset.Colors.background.swiftUIColor.opacity(0.2)) {
//                                selection = 1
//                            }
//                        })
//
//                        NavigationLink (destination: RegistrationMainView().navigationBarBackButtonHidden(true), tag: 2, selection: $selection, label: {
//                            AccentButton(text: Strings.createAccount,
//                                         foregroundColor: Asset.Colors.mainFontColor.swiftUIColor,
//                                         backgroundColor: Asset.Colors.background.swiftUIColor) {
//                                selection = 2
//                            }
//                        })
//                    }
//                    .padding(.horizontal, 8)
//                    .padding(.bottom, 51)
//                })
            case .loading:
                VStack {
                    Text("Здесь будет загрузка")
                }
            }
        }
    }
}

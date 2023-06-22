//
//  MainView.swift
//  Jumpeak
//
//  Created by Денис Большачков on 30.05.2023.
//

import SwiftUI
import CardStack

struct MainView: View {
    @State private var selection = 0
    
    var vacancy: Vacancy?
    @State private var cards = [Vacancy(id: UUID(), title: "sdfsda", description: "sfdfds", cardImage: Image("bg"), logo: Image("bg"), skills: [HardSkill(name: "Пить пиво")], salary: 75000)]
    
    var body: some View {
        TabView(selection: $selection) {
            main
                .tag(0)
                .tabItem {
                    Label("Vancies", systemImage: "mail.stack")
                }
            
            messages
                .tag(1)
                .tabItem {
                    Label("Message", systemImage: "message")
                }
            
            profile
                .tag(2)
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
            
        }
        .background(Asset.Colors.background.swiftUIColor)
        .preferredColorScheme(.light)
    }
    
    var main: some View {
        VStack {
            CardStack(
                direction: LeftRight.direction, // See below for directions
                data: cards,
                onSwipe: { card, direction in // Closure to be called when a card is swiped.
                    print("Swiped \(card) to \(direction)")
                },
                content: { card, direction, isOnTop in // View builder function
                    CardView(vacancy: Vacancy(id: UUID(), title: "Ищем архитектора Data Platform в Яндекс Клауд", description: "Сложные задачи для сервисов с миллионами пользователей", cardImage: Image("bg"), logo: Image("logo"), skills:
                                                [HardSkill(name: "SwiftUI"), HardSkill(name: "Swift")], salary: 75000))
                    .padding(.horizontal, 16)
                    .padding(.bottom, 12)
                    
                }
            )
        }
        .background(Asset.Colors.background.swiftUIColor)
    }
    
    var messages: some View {
        VStack {
            
        }
    }
    
    var profile: some View {
        VStack {
            
        }
    }
}



struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


struct Vacancy: Identifiable {
    var id: UUID
    var title: String
    var description: String
    var cardImage: Image
    var logo: Image
    var skills: [HardSkill]
    var salary: Double
}

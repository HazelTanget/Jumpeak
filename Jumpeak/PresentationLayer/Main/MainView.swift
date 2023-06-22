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
    @State private var shouldShowProffessions = false
    
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
        VStack (spacing: 0) {
            HStack {
                VStack {
                    Menu {
                        Button {
                            // do something
                        } label: {
                            Text("Linear")
                        }
                        Button {
                            // do something
                        } label: {
                            Text("Radial")
                        }
                    } label: {
                        HStack {
                            Text("Разработчик базы данных")
                                .lFont()
                                .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)

                            Spacer()

                            Image(systemName: "chevron.down")
                                .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)

                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .background(Asset.Colors.inputColor.swiftUIColor)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.leading, 16)
                        .padding(.trailing, 8)

                    }
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "bell")
                        .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(Asset.Colors.inputColor.swiftUIColor)
                .clipShape(Circle())
                .padding(.trailing, 16)

            }
            .padding(.top, 0.3)
            
            Spacer()

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
            .padding(.top, 16)
            
            HStack (spacing: 8) {
                Button {
                    
                } label: {
                    HStack {
                        Image(systemName: "xmark")
                            .background(Asset.Colors.background.swiftUIColor)
                            .foregroundColor(Asset.Colors.errorColor.swiftUIColor)
                            .clipShape(Circle())
                        
                        Text("Скипнуть")
                            .mFont()
                            .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                .background(Asset.Colors.inputColor.swiftUIColor)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                
//                Button {
//
//                } label: {
//                    HStack {
//                        Image(systemName: "info.circle")
//                            .fontWeight(.medium)
//                            .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
//                            .background(Asset.Colors.background.swiftUIColor)
//
//                            .clipShape(Circle())
//                    }
//                }
//                .padding(.horizontal, 16)
//                .padding(.vertical, 16)
//                .background(Asset.Colors.inputColor.swiftUIColor)
//                .clipShape(RoundedRectangle(cornerRadius: 24))
                
                Button {
                    
                } label: {
                    HStack {
                        Image(systemName: "hand.thumbsup")
                            .background(Asset.Colors.background.swiftUIColor)
                            .foregroundColor(Asset.Colors.successColor.swiftUIColor)
                            .clipShape(Circle())
                        
                        Text("Нравится")
                            .mFont()
                            .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                .background(Asset.Colors.inputColor.swiftUIColor)
                .clipShape(RoundedRectangle(cornerRadius: 24))
            }
            .background(Asset.Colors.background.swiftUIColor)
            .padding(.bottom, 16)
            
            
            RoundedRectangle(cornerRadius: 8)
                .fill(Asset.Colors.inputColor.swiftUIColor)
                .frame(height: 1)
                .padding(.bottom, 8)
            
        }
        .background(Asset.Colors.background.swiftUIColor)
    }
    
    var messages: some View {
        VStack {
            Text("Чаты")
                .lFont()
                .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
            
            ScrollView(showsIndicators: false) {
                VStack (spacing: 8) {
                    ForEach(0..<6) { item in
                        HStack {
                            VStack (alignment: .leading) {
                                Text("АО Бифит")
                                    .lFont(weight: .medium)
                                    .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
                                
                                Text("Работадатель заинтересованн")
                                    .sFont(weight: .medium)
                                    .foregroundColor(Asset.Colors.successColor.swiftUIColor.opacity(0.7))
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Asset.Colors.inputColor.swiftUIColor)
                        .padding(.horizontal, 16)
                    }
                }
            }
        }
    }
    
    var profile: some View {
        StepMenu()
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

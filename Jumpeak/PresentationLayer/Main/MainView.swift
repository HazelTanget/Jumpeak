//
//  MainView.swift
//  Jumpeak
//
//  Created by Денис Большачков on 30.05.2023.
//

import SwiftUI
import CardStack
import FirebaseFirestoreSwift
import FirebaseFirestore
import FirebaseAuth


struct MainView: View {
    @State private var selection = 0
    @State private var shouldShowProffessions = false
    @State var write = ""
    
    @State var selectedChat: Chat?
    
    @ObservedObject var viewModel = ApplicationAssemby.defaultContainer.resolve(MainViewViewModel.self)!
    
    var vacancy: Vacancy?
    
    var body: some View {
        TabView(selection: $selection) {
            main
                .tag(0)
                .tabItem {
                    Label("Vancies", systemImage: "mail.stack")
                }
                .onAppear {
                    viewModel.getVacancies()
                    viewModel.getMessages()
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
                            Text("iOS Разработчик")
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
                data: viewModel.vacancies,
                onSwipe: { card, direction in // Closure to be called when a card is swiped.
                    print("Swiped \(card) to \(direction)")
                },
                content: { card, direction, isOnTop in // View builder function
                    CardView(vacancy: card)
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
        NavigationStack(path: $viewModel.path) {
            VStack {
                Text("Чаты")
                    .lFont()
                    .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
                
                ScrollView(showsIndicators: false) {
                    VStack (spacing: 8) {
                        ForEach(viewModel.chat, id: \.id) { item in
                            HStack {
                                VStack (alignment: .leading) {
                                    Text("Яндекс")
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
                            .onTapGesture {
                                viewModel.path.append(item)
                                selectedChat = item
                                viewModel.observeMessages(uid: item.id ?? "")
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: Chat.self) { value in
                buildChartDetailView()
            }
        }
    }
    
    @ViewBuilder
    private func buildChartDetailView() -> some View {
        let uid = Auth.auth().currentUser?.uid ?? ""
        
        VStack {
            Text("Чат с работадателем")
                .lFont()
                .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
            
            Spacer()
            
            ScrollView {
                VStack {
                    ForEach(viewModel.messages, id: \.id) { message in
                        ChatRow(message: message, uid: uid)
                            .padding(.vertical,8)
                            .padding(.horizontal,8)
                    }
                }
            }
            
//            VStack {
//                ForEach(chat.Messages, id: \.id) { item in
//                    if item.User1 == uid {
//                        HStack {
//                            Spacer()
//                            Text(item.Text ?? "")
//                                .modifier(chatModifier(myMessage: true))
//                        }.padding(.leading,75)
//                    } else {
//                        HStack {
//                            Text(item.Text ?? "")
//                                .modifier(chatModifier(myMessage: false))
//                            Spacer()
//                        }.padding(.trailing,75)
//                    }
//                }
//            }
//
            HStack {
                TextField("message...",text: self.$write).padding(10)
                    .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                .cornerRadius(25)
                
                Button(action: {
                    if self.write.count > 0 {
                        uploadMessage(chat: selectedChat ?? Chat(User1: "", User2: ""), message: Message(DateTime: Date(), IDUser: uid, Text: write))
                        self.write = ""
                    } else {
                        
                    }
                }) {
                    Image(systemName: "paperplane.fill").font(.system(size: 20))
                        .foregroundColor((self.write.count > 0) ? Color.blue : Color.gray)
                        .rotationEffect(.degrees(50))
                    
                }
            }.padding()
             .padding(.bottom)
            
        }
        
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
    
    func uploadMessage(chat: Chat, message: Message) {
        try? Firestore.firestore()
            .collection(FirebaseCollection.chat.rawValue)
            .document(chat.id ?? "")
            .collection("Messages")
            .addDocument(from: message)
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


struct Vacancy: Codable, Identifiable {
    @DocumentID var id: String?
    var title: String
    var description: String
    var cardImage: String
    var skills: [String]
    var salary: Double
    var companyID: String
}

struct chatModifier : ViewModifier{
    var myMessage : Bool
    func body(content: Content) -> some View {
        content
            .padding(10)
            .background(myMessage ? Color.blue : Color.black.opacity(0.5))
            .cornerRadius(7)
            .foregroundColor(Color.white)
    }
}

struct ChatRow: View {
    
    var message: Message
    var uid: String
    
    var body: some View {
        HStack {
            if message.IDUser == uid {
                HStack {
                    Spacer()
                    Text(message.Text ?? "")
                        .modifier(chatModifier(myMessage: true))
                }.padding(.leading,75)
            } else {
                HStack {
                    Text(message.Text ?? "")
                        .modifier(chatModifier(myMessage: false))
                    Spacer()
                }.padding(.trailing,75)
            }
        }

    }
}

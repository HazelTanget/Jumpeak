//
//  MainViewViewModel.swift
//  Jumpeak
//
//  Created by Денис Большачков on 23/06/23.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI
import FirebaseAuth

final class MainViewViewModel: ObservableObject {
 
    var sessionService: SessionService!
    
    @Published var vacancies = [Vacancy]()
    @Published var path = NavigationPath()
    @Published var chat = [Chat]()
    @Published var messages = [Message]()
    
    func getSelectedProffession() -> String {
        return sessionService.savedData?.selectedProffessions.first?.name ?? ""
    }
    
    func getVacancies() {
        Firestore.firestore()
            .collection(FirebaseCollection.vacancies.rawValue)
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                let projects = documents.compactMap { queryDocumentSnapshot -> Vacancy? in
                    
                    return try? queryDocumentSnapshot.data(as: Vacancy.self)
                }
                
                self.vacancies = projects
            }
    }
    
    func getMessages() {
        let uid = Auth.auth().currentUser?.uid
        
        Firestore.firestore()
            .collection(FirebaseCollection.chat.rawValue)
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                var projects = documents.compactMap { queryDocumentSnapshot -> Chat? in
                    return try? queryDocumentSnapshot.data(as: Chat.self)
                }.filter { $0.User1 == uid}
                
                
                projects.forEach { item in
                    Firestore.firestore()
                        .collection(FirebaseCollection.chat.rawValue)
                        .document(item.id ?? "")
                        .collection("Messages")
                        .order(by: "DateTime")
                        .addSnapshotListener { snapshot, error in
                            self.chat = []
                            guard let documents = snapshot?.documents else {
                                print("Error fetching documents: \(error!)")
                                return
                            }
                            
                            let messages = documents.compactMap { queryDocumentSnapshot -> Message? in
                                return try? queryDocumentSnapshot.data(as: Message.self)
                            }

                           
                            self.chat.append(Chat(id: item.id, User1: item.User1, User2: item.User2, Messages: messages))
                            
                        }
                    
                    
                    
                }
            }
    }
    
    func observeMessages(uid: String) {
        Firestore.firestore()
            .collection(FirebaseCollection.chat.rawValue)
            .document(uid)
            .collection("Messages")
            .order(by: "DateTime")
            .addSnapshotListener {snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                let messages = documents.compactMap { queryDocumentSnapshot -> Message? in
                    return try? queryDocumentSnapshot.data(as: Message.self)
                }
                
                self.messages = messages
            }
    }
}


struct Chat: Codable, Hashable {
    static func == (lhs: Chat, rhs: Chat) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    @DocumentID var id: String?
    var User1: String
    var User2: String
    var Messages = [Message]()
    
    
    enum CodingKeys: String, CodingKey {
        case id, User1, User2
    }
}

struct Message: Codable {
    @DocumentID var id: String?
    var DateTime: Date
    var IDUser: String
    var Text: String
    
    
}



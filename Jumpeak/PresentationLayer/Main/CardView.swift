//
//  CardView.swift
//  Jumpeak
//
//  Created by Денис Большачков on 30.05.2023.
//

import SwiftUI
import FirebaseStorage
import Kingfisher

struct CardView: View {
    var vacancy: Vacancy?
    @State var url: URL?
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            employerView()
                .onAppear { getImage() }
            //            if card != nil {
            //                studentView()
            //            } else {
            //                employerView()
            //            }
        }
    }
    
    //    @ViewBuilder
    //    private func studentView() -> some View {
    //        ZStack {
    //
    //
    //            VStack (alignment: .leading) {
    //                Image("man")
    //                    .resizable()
    //                    .frame(width: 144, height: 144)
    //                    .cornerRadius(20)
    //
    //                Text(card?.lastName ?? "" + " " + (card?.firstName ?? ""))
    //                    .font(.system(size: 32))
    //
    //                HStack {
    //                    buildSkills(skills: card?.skills ?? [])
    //                }
    //                .frame(maxWidth: .infinity, alignment: .topLeading)
    //
    //                Text("Описание:")
    //                    .fontWeight(.bold)
    //
    //
    //                Text(card?.description ?? "")
    //
    //                Spacer()
    //            }
    //            .padding()
    //
    //
    //        }
    //        .frame(maxWidth: .infinity, maxHeight: .infinity)
    //        .background(
    //            LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.3), Color.white.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
    //        )
    //        .cornerRadius(20)
    //    }
    
    @ViewBuilder
    private func employerView() -> some View {
        ZStack {
            KFImage(url)
                .placeholder {
                    Asset.Colors.inputColor.swiftUIColor
                }
                .resizable()
            
            VStack {
                Spacer()
                
                buildSkills(skills: vacancy?.skills ?? [])
                
                
                VStack (alignment: .leading) {
                    Text(vacancy?.title ?? "")
                        .xlFont()
                        .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
                    
                    Text(vacancy?.description ?? "")
                        .mFont()
                        .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
                        .padding(.top, 8)
                    
                 
                    VStack {
                        HStack {
                            Text(Strings.salary.uppercased())
                                .sFont(weight: .medium)
                                .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor.opacity(0.4))
                                
                            Spacer()
                            Text("От 75 000 ₽")
                                .lFont(weight: .medium)
                                .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
                        }
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Asset.Colors.inputColor.swiftUIColor)
                            .frame(height: 1)
                        
                        
                        HStack {
                            Text(Strings.typeOfEmployment.uppercased())
                                .sFont(weight: .medium)
                                .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor.opacity(0.4))
                            
                            Spacer()
                            Text("Работа в офисе")
                                .lFont(weight: .medium)
                                .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
                        }
                    }
                    .padding(.top, 40)

                }
                .padding(.vertical, 16)
                .padding(.horizontal, 16)
                .background(Asset.Colors.background.swiftUIColor)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 8)
            
            
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.2), Color.white.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(20)
    }
    
    @ViewBuilder
    private func buildSkills(skills: [String]) -> some View {
        HStack  {
            ForEach(skills, id: \.self) { skill in
                Text(skill)
                    .font(.system(size: 18))
                    .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 8)
                    .padding(.horizontal)
                    .background(.white)
                    .cornerRadius(24)
            }
        }
    }
    
    func getImage() {
        guard let path = vacancy?.cardImage else { return }
        let storage = Storage.storage()
        storage.reference().child(path).downloadURL(completion: { url, error in
            guard let url = url else {
                return
            }
            self.url = url
        })
    }
}

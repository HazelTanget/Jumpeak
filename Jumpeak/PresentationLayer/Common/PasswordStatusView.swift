//
//  PasswordStatusView.swift
//  Jumpeak
//
//  Created by Денис Большачков on 17.04.2023.
//

import SwiftUI

struct PasswordStatusView: View {
    @Binding var text: String
  
    var padding: CGFloat = 4
    var body: some View {
        switch text.count {
        case 0..<8:
            errorInput
        case 0..<12:
            warningInput
        case 0..<15:
            successInput
        default:
            Asset.Assets.errorPasswordIc.swiftUIImage
                .resizable()
                .frame(width: 18, height: 18)
        }
    }
    
    var errorInput: some View {
        HStack {
            Asset.Assets.errorPasswordIc.swiftUIImage
                .resizable()
                .frame(width: 18, height: 18)
            
            Rectangle()
                .fill(Asset.Colors.inputColor.swiftUIColor)
                .frame(width: 40, height: 4)
                .padding(.leading, padding)
                .cornerRadius(2)
        }
    }
    
    var warningInput: some View {
        HStack {
            Asset.Assets.warningPasswordIc.swiftUIImage
                .resizable()
                .frame(width: 18, height: 18)
            
            Text(Strings.weak)
                .sFont()
                .foregroundColor(Asset.Colors.warningColor.swiftUIColor)
                .padding(.leading, padding)
            
            ZStack (alignment: .leading) {
                Rectangle()
                    .fill(Asset.Colors.inputColor.swiftUIColor)
                    .cornerRadius(2)

                Rectangle()
                    .fill(Asset.Colors.warningColor.swiftUIColor)
                    .frame(width: 20)
                    .cornerRadius(2)
            }
            .frame(width: 40, height: 4)
            .padding(.leading, padding)
        }
    }
    
    var successInput: some View {
        HStack {
            Asset.Assets.successPasswordIc.swiftUIImage
                .resizable()
                .frame(width: 18, height: 18)
            
            Text(Strings.strong)
                .sFont()
                .foregroundColor(Asset.Colors.successColor.swiftUIColor)
            .padding(.leading, padding)
            
            ZStack (alignment: .leading) {
                Rectangle()
                    .fill(Asset.Colors.successColor.swiftUIColor)
                    .frame(width: 20)
                    .cornerRadius(2)
            }
            .frame(width: 40, height: 4)
            .padding(.leading, padding)
        }
    }
}

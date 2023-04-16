//
//  BackBarButton.swift
//  Jumpeak
//
//  Created by Денис Большачков on 10.04.2023.
//

import SwiftUI

struct BackBarButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.left")
                .foregroundColor(Asset.Colors.backBarButtonColor.swiftUIColor)
                .font(.system(size: 14, weight: .medium))
        })
    }
}

struct BackBarButton_Previews: PreviewProvider {
    static var previews: some View {
        BackBarButton()
    }
}

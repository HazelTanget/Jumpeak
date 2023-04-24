//
//  CodeFieldsView.swift
//  Jumpeak
//
//  Created by Денис Большачков on 16.04.2023.
//

import SwiftUI

struct CodeFieldsView: View {
    @Binding var codeFields: [String]
    @FocusState private var activeField: CodeField?

    var body: some View {
        CodeFields()
            .onChange(of: codeFields) { newValue in
                codeCondition(value: newValue)
            }
    }

    func codeCondition(value: [String]) {
        for index in 0..<4 {
            if value[index].count == 1 && activateStateForIndex(index: index) == activeField {
                activeField = activateStateForIndex(index: index + 1)
            }
        }
        
        for index in 1...4 {
            if value[index].isEmpty && !value[index - 1].isEmpty {
                activeField = activateStateForIndex(index: index - 1)
            }
        }

        for index in 0..<5 {
            if value[index].count > 1 {
                codeFields[index] = String(value[index].last!)
            }
        }

    }

    func activateStateForIndex(index: Int) -> CodeField {
        switch index {
        case 0: return .field1
        case 1: return .field2
        case 2: return .field3
        case 3: return .field4
        case 4: return .field5
        default: return  .field1
        }
    }
    
    @ViewBuilder
    private func CodeFields() -> some View {
        HStack (spacing: 8) {
            ForEach(0..<5) { index in
                TextField("", text: $codeFields[index])
                    .padding(.vertical, 20)
                    .padding(.horizontal, 26)
                    .background(Asset.Colors.inputColor.swiftUIColor)
                    .cornerRadius(8)
                    .overlay {
                        if activeField == activateStateForIndex(index: index) {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 2)
                                .fill(Asset.Colors.accentColor.swiftUIColor)
                        }
                    }
                    .keyboardType(.numberPad)
                    .textContentType(.oneTimeCode)
                    .multilineTextAlignment(.center)
                    .focused($activeField, equals: activateStateForIndex(index: index))
            }
        }
    }
}

//MARK: FocusState enum
enum CodeField {
    case field1
    case field2
    case field3
    case field4
    case field5
}

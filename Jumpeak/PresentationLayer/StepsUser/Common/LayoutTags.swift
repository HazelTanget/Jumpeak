//
//  LayoutTags.swift
//  Jumpeak
//
//  Created by Денис Большачков on 24.04.2023.
//

import SwiftUI

struct LayoutTags: View {
    @Binding var tag: [Tag]
    
    var body: some View {
        VStack {
            TagLayout(spacing: 8) {
                ForEach($tag, id: \.id) { $tag in
//                    if index == tag.count - 1 {
//                        Button {
//
//                        } label: {
//                            Text(tag[index].name)
//                                .mFont()
//                                .foregroundColor(Asset.Colors.accentColor.swiftUIColor)
//                        }
//                        .padding(.vertical, 12)
//                        .padding(.horizontal, 16)
//                        .background(Asset.Colors.inputColor.swiftUIColor)
//                        .cornerRadius(8)
//
//                    } else {
                        Toggle(isOn: $tag.isSelected) {
                            Text(tag.name)
                                .mFont()
                                .foregroundColor(tag.isSelected ? Asset.Colors.thirdFontColor.swiftUIColor : Asset.Colors.mainFontColor.swiftUIColor)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 16)
                            
                        }
                        .toggleStyle(.button)
                        .tint(Asset.Colors.accentColor.swiftUIColor)
                        .background(tag.isSelected ? Asset.Colors.accentColor.swiftUIColor : Asset.Colors.inputColor.swiftUIColor)
                        .cornerRadius(8)
//                    }
                    
                }
                
            }
        }
    }
}

struct TagLayout: Layout {
    var alignment = Alignment.center
    var spacing: CGFloat = 8
    
    init(alignment: SwiftUI.Alignment = Alignment.center, spacing: CGFloat) {
        self.alignment = alignment
        self.spacing = spacing
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        return CGSize(width: proposal.width ?? 0, height: proposal.height ?? 0)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var origin = bounds.origin
        let maxWidth = bounds.width
        
        subviews.forEach { view in
            let viewSize = view.sizeThatFits(proposal)
            if (origin.x + viewSize.width + spacing) > maxWidth {
                origin.y += viewSize.height + spacing
                origin.x = bounds.origin.x

                view.place(at: origin, proposal: proposal)
                origin.x += viewSize.width + spacing
            } else {
                view.place(at: origin, proposal: proposal)
                origin.x += viewSize.width + spacing
            }
        }
    }
    
}

struct Tag: Identifiable {
    var id = UUID().uuidString
    var name: String
    var isSelected: Bool = false
}

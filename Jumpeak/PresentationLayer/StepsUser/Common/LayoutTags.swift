//
//  LayoutTags.swift
//  Jumpeak
//
//  Created by Денис Большачков on 24.04.2023.
//

import SwiftUI

struct LayoutTags: View {
    @Binding var tag: [Tag]
    var isProffessionView: Bool
    
    init(tag: Binding<[Tag]>, isProffessionView: Bool = false) {
        self._tag = tag
        self.isProffessionView = isProffessionView
    }
    
    var hasSelectedTag: Bool {
        var countOfSelected = 0
        tag.forEach { tag in
            if tag.isSelected {
                countOfSelected += 1
            }
        }
        return isProffessionView && countOfSelected > 1
    }
    
    var body: some View {
        VStack {
            TagLayout(spacing: 8) {
                ForEach($tag, id: \.id) { $tag in
                    Toggle(isOn: $tag.isSelected) {
                        Text(tag.name)
                            .mFont()
                            .foregroundColor(tag.isSelected ? Asset.Colors.thirdFontColor.swiftUIColor : Asset.Colors.mainFontColor.swiftUIColor)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                        
                    }
                    .onChange(of: tag.isSelected) { newValue in
                        if hasSelectedTag {
                            tag.isSelected = !newValue
                        }
                    }
                    .toggleStyle(.button)
                    .tint(Asset.Colors.accentColor.swiftUIColor)
                    .background(tag.isSelected ? Asset.Colors.accentColor.swiftUIColor : Asset.Colors.inputColor.swiftUIColor)
                    .cornerRadius(8)
                    
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

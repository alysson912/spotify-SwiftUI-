//
//  CategoryCell.swift
//  SwiftFulSpotify
//
//  Created by ALYSSON MENEZES on 30/06/25.
//

import SwiftUI

struct CategoryCell: View {
    
    var title: String = "all"
    var isSelected: Bool = false
    
    
    var body: some View {
        Text(title)
            .font(.callout)
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .frame(minWidth: 35)
            // caso selecionado cor 1, caso o contrario cor 2
            .themeColors(isSelected: isSelected)
            //.cornerRadius(16) //Will be deprecated
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

extension View {
    func themeColors(isSelected: Bool) -> some View{
        self
            .background(isSelected ? .spotifyGreen : .spotifyDarkGray)
            .foregroundStyle(isSelected ? .spotifyBlack : .spotifyWhite)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea(edges: .all)
        VStack(spacing: 40) {
            CategoryCell(title: "Title goes here", isSelected: false)
            CategoryCell(title: "all", isSelected: true)
            CategoryCell(title: "music", isSelected: false)
            CategoryCell(title: "podcasts", isSelected: true)
        }
        
    }
}

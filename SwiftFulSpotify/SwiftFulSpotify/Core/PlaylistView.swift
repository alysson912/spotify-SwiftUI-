//
//  DetailPlaylistView.swift
//  SwiftFulSpotify
//
//  Created by ALYSSON MENEZES on 11/07/25.
//

import SwiftUI

struct PlaylistView: View {
    
    var product: Product = .mock
    var user: User = .mock
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack (spacing: 12) {
                    PlaylistHeaderCell(
                        height: 250,
                        title: product.title,
                        subtitle: product.brand ?? "",
                        imageName: product.thumbnail
                        
                    )
                    PlaylistDescriptionCell(
                        descriptionText: product.description,
                        userName: user.firstName,
                        subHeadline: product.category,
                        onAddToPlayListPressed: nil,
                        ondDownloadPressed: nil,
                        onsharedPressed: nil,
                        onEllipsisPressed: nil,
                        onShufflePressded: nil,
                        onPlayPressed: nil
                        
                    )
                    .padding(.horizontal, 16)
                }
                
            }
        }
    }
}

#Preview {
    PlaylistView()
}

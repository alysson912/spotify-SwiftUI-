//
//  PlaylistDescriptionCell.swift
//  SwiftFulSpotify
//
//  Created by ALYSSON MENEZES on 16/07/25.
//

import SwiftUI

struct PlaylistDescriptionCell: View {

    var descriptionText: String = Product.mock.description
    var userName: String = "Alysson"
    var subHeadline: String = "Some headline goes here"
    var onAddToPlayListPressed: (() -> Void)? = nil // func para adicionar acao a um item
    var ondDownloadPressed: (() -> Void)? = nil
    var onsharedPressed: (() -> Void)? = nil
    var onEllipsisPressed: (() -> Void)? = nil
    var onShufflePressded: (() -> Void)? = nil
    var onPlayPressed: (() -> Void)? = nil
    
    var body: some View {
        VStack (alignment: .leading, spacing: 8){
            Text(descriptionText)
                .foregroundStyle(.spotifyLightGray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            madeForYouSection
            Text(subHeadline)            
            buttonsRows
            
        }
        .font(.callout)
       // .fontWeight(.medium) iOS 16+
        .foregroundStyle(.spotifyLightGray)
    }
    
    private var madeForYouSection: some View {
        HStack (spacing: 8) {
            Image(systemName: "applelogo")
                .font(.title3)
                .foregroundStyle(.spotifyGreen)
            
            Text("Made for ")
            + Text(userName)
  
        }
    }
    private var buttonsRows: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                Image(systemName: "plus.circle")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
                Image(systemName: "arrow.down.circle")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
                Image(systemName: "square.and.arrow.up")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
                Image(systemName: "ellipsis")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
            }
            .offset(x: -8)
            .frame(maxWidth: .infinity, alignment: .leading)
        
        HStack(spacing: 8) {
            Image(systemName: "shuffle")
                .font(.system(size: 24))
                
                .background(Color.black.opacity(0.001))
                .onTapGesture {
                }
            
            Image(systemName: "play.circle.fill")
                .font(.system(size: 46))
                
                .background(Color.black.opacity(0.001))
                .onTapGesture {
                }

            
            }
        .foregroundStyle(.spotifyGreen)
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        PlaylistDescriptionCell()
    }
}

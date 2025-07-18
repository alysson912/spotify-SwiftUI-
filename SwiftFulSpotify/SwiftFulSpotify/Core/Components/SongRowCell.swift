//
//  SongRowCell.swift
//  SwiftFulSpotify
//
//  Created by ALYSSON MENEZES on 16/07/25.
//

import SwiftUI

struct SongRowCell: View {
    
    var imageSize: CGFloat = 50
    var imageName: String = Constants.randomImage
    var title: String = "Some song name goes here"
    var subTitle: String? = "Some artist name goes here"
    var onCellPressed: (() -> Void)? = nil // acao generica
    var onElipsisPressed: (() -> Void)? = nil // acao generica
    
    var body: some View {
        HStack(spacing: 9) {
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize, height: imageSize)
            
            VStack {
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundStyle(.spotifyWhite)
                
                if let subTitle {
                    Text(subTitle)
                        .font(.callout)
                        .foregroundStyle(.spotifyLightGray)
                }
            }
            .lineLimit(2)
            .frame(maxWidth: .infinity, alignment: .leading)
          //  .background(Color.blue)
            
            Image(systemName: "ellipsis")
                .font(.headline)
                .padding(16)
                .foregroundStyle(.spotifyLightGray)
                .background(Color.black.opacity(0.001))
                .onTapGesture {
                    onElipsisPressed?()
                }
        }
        .background(Color.black.opacity(0.001))
        .onTapGesture {
            onCellPressed?()
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        VStack {
            SongRowCell()
            SongRowCell()
            SongRowCell()
            SongRowCell()
            
        }
    }
}

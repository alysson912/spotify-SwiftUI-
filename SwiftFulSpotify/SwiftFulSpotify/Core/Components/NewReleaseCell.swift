//
//  NewReleaseCell.swift
//  SwiftFulSpotify
//
//  Created by ALYSSON MENEZES on 10/07/25.
//

import SwiftUI

struct NewReleaseCell: View {
    
    
    var imageName: String = Constants.randomImage
    var headline: String? = "New release from"
    var subHeadline: String? = "Some Artist"
    var title: String? = "Some Playlist"
    var subtitle: String? = "Single - title"

    var body: some View {
        VStack (spacing: 16){
            HStack (spacing: 8){
                ImageLoaderView(urlString: imageName)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                VStack(spacing: 2){
                    if let headline {
                        Text(headline)
                            .foregroundStyle(.spotifyLightGray)
                            .font(.callout)
                        
                    }
                    
                    if let subHeadline {
                        Text(subHeadline)
                            .foregroundStyle(.spotifyLightGray)
                            .font(.title2)
                         //   .fontWeight(.medium)
                            .foregroundStyle(.spotifyWhite)
                    }
                    
                }
            }
         //   .background(Color.red)
        
        .frame(maxWidth: .infinity, alignment: .leading)
       // .background(Color.blue)
        
            HStack (){
                ImageLoaderView(urlString: imageName)
                    .frame(width: 140, height: 140)
                
                VStack (alignment: .leading, spacing: 32){
                    VStack (alignment: .leading, spacing: 2){
                        if let title {
                            Text(title)
                                .fontWeight(.semibold)
                                .foregroundStyle(.spotifyWhite)
                        }
                        
                        if let subtitle {
                            Text(subtitle)
                                .foregroundStyle(.spotifyLightGray)
                        }
                                            
                    }
                    .font(.callout)
                    
                    HStack(spacing: 0) {
                         Image(systemName: "plus.circle")
                            .foregroundStyle(.spotifyLightGray)
                            .font(.title3)
                            .onTapGesture {
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(systemName: "play.circle.fill")
                           .foregroundStyle(.spotifyWhite)
                           .font(.title3)
                           .onTapGesture {
                               
                           }
                    }
                }
                .padding(.trailing, 16)
            }
        //    .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .themeColors(isSelected: false)
        }
        
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        NewReleaseCell()
            .padding()
    }
}

//
//  ImageTitleRowCell.swift
//  SwiftFulSpotify
//
//  Created by ALYSSON MENEZES on 10/07/25.
//

import SwiftUI

struct ImageTitleRowCell: View {
    
    var imageSize: CGFloat = 100
    var imageName: String = Constants.randomImage
    var title: String = "Some Item Name"
    
    var body: some View {
        VStack (alignment: .leading, spacing: 8 ){
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize, height: imageSize)
            
            Text(title)
                .font(.callout)
                .foregroundStyle(.spotifyLightGray)
                .padding(4)
        }
        .frame(width: imageSize)// a view terá o tamanho da imagem
      //  .background(Color.red)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        ImageTitleRowCell()
    }
}

//
//  DetailPlaylistView.swift
//  SwiftFulSpotify
//
//  Created by ALYSSON MENEZES on 11/07/25.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct PlaylistView: View {
    
    @Environment(\.router) var router
    var product: Product = .mock
    var user: User = .mock
    
    @State private var products: [Product] = []
    @State private var showHeader: Bool = true
     
    
    
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
                    .readingFrame(onChange: { frame in
                        showHeader = frame.maxY < 150
                    })
                    .overlay(
                        GeometryReader(content: { geometry in
                           Text("")
                                .frame(maxWidth: .infinity,maxHeight: .infinity)
                            //    .background(Color.red)
                        })
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
                    
                    ForEach(products){ product in
                        SongRowCell(
                            imageSize: 50,
                            imageName: product.firstImage,
                            title: product.title,
                            subTitle: product.brand,
                            onCellPressed: {
                                goToPlayListView(product: product )
                            },
                            onElipsisPressed: {
                                
                            }
                            
                        )
                        .padding(.leading, 16)
                    }
                }
            }
           
            header
            
                .frame(maxHeight: .infinity, alignment: .top)
                
            
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar) // iOS 16+
    }
    
    //MARK: FUNCS
    private func getData() async {
        do {
            products = try await  DatabaseHelper().getProducts()// limitando para 8 itens
            
        } catch {
            
        }
    }
    
    private func goToPlayListView(product: Product) {
        router.showScreen(.push) {_ in
            PlaylistView(product: product, user: user)
        }
    }
    
    private var header: some View {
        
        ZStack {
            Text(product.title)
                .font(.headline)
                .foregroundStyle(.spotifyWhite)
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(.spotifyBlack)
                .offset(y: showHeader ? 0: -40)
                .opacity(showHeader ? 1 : 0)
                
            Image(systemName: "chevron.left")
                .font(.title3)
                .padding(10)
                .background(showHeader ? Color.black.opacity(0.001) : Color.spotifyGray.opacity(0.7))
                .clipShape(Circle())
                .onTapGesture {
                    router.dismissScreen()
                }
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundStyle(.spotifyWhite)
      //  .background(Color.blue)
        .animation(.smooth(duration: 2.0), value: showHeader)
    }
}

#Preview {
    RouterView {_ in
        PlaylistView()
        
    }
}

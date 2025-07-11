//
//  HomeView.swift
//  SwiftFulSpotify
//
//  Created by ALYSSON MENEZES on 30/06/25.
//

import SwiftUI
import SwiftfulUI // SDK SwiftFulThinking

struct HomeView: View {
    
    @State private var currentUser: User? = nil
    @State private var selectedCategory: Category? = nil
    @State private var products: [Product] = []
    @State private var productsRows: [ProductRow] = []
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 1, pinnedViews: [.sectionHeaders], content: {
                    Section {
                        VStack (spacing: 16){
                            recentsSection
                                .padding(.horizontal, 16)
                            
                            if let product = products.first {
                                newReleasesSection(product: product)
                                
                            }
                            listRows
                            
                        }
                        .padding(.horizontal, 16)
                        
                        
                        
                    } header: {
                        header
                    }
                })
                .padding(.top, 8)
                //   .scrollIndicators(.hidden) //ios16+
            }
            .clipped()
        }
        .task {
            await getData()
        }
        .navigationBarHidden(true) // Oculta a barra
        // .toolbar(.hidden, for: .navigationBar) //iOS 16+
    }
    
    
    //MARK: FUNCS
    private func getData() async {
        do {
            currentUser = try await DatabaseHelper().getUsers().first
            products = try await  Array(DatabaseHelper().getProducts().prefix(8))// limitando para 8 itens
            
            var rows: [ProductRow] = []
            let allBrands = Set(products.map({$0.brand})) // set evita duplicar valores
            for brand in allBrands {
                //   let products = self.products.filter({$0.brand == brand})
                rows.append(ProductRow(title: brand ?? "", products: products))
            }
            productsRows = rows
        } catch {
            
        }
    }
    
    
    //MARK: UI COMPONENTS
    private var header : some View {
        HStack (spacing: 0){
            ZStack {
                if let currentUser = currentUser {
                    ImageLoaderView()
                    
                        .background(.spotifyWhite)
                        .clipShape(Circle())
                        .onTapGesture {
                            
                        }
                }
            }
            .frame(width: 40, height: 40)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack (spacing: 8.0) {
                    //MARK: enum com os Itens
                    ForEach(Category.allCases, id: \.self) { category in
                        CategoryCell(title: category.rawValue.capitalized, isSelected: category == selectedCategory)
                        //
                            .onTapGesture {
                                selectedCategory = category
                            }
                    }
                }
                
                .padding(.horizontal, 16)
            }
            //   .scrollIndicators(.hidden) //ios16+
        }
        .padding(.vertical, 24)
        .padding(.leading, 8)
        .frame(maxWidth: .infinity)
        .background(Color.spotifyBlack)
    }
    //MARK: COMPONENT GRID DO SDK
    private var recentsSection: some View {
        
        NonLazyVGrid(columns: 2, alignment: .center, spacing: 10, items: products) { product in
            if let product {
                RecentsCell(
                    imageName: product.firstImage,
                    title: product.title
                )
                //MARK: SDK SWIFTFULTHINKING
                .asButton (.press){
                    
                }
            }
        }
    }
    
    private func newReleasesSection(product: Product) -> some View {
        NewReleaseCell(
            
            imageName: product.firstImage,
            headline: product.brand,
            subHeadline: product.category,
            title: product.title,
            subtitle: product.description,
            
            onAddToPlayListPressed: {
                //MARK: IMPREMENTAR ACTION BUTTON
            },
            
            onPlayPressed: {
                //MARK: IMPREMENTAR ACTION BUTTON
            }
        )
    }
    
    private var listRows: some View {
        ForEach(productsRows) { row in
            VStack (spacing: 8) {
                Text(row.title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.spotifyWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                //  .background(Color.blue)
                    .padding(.horizontal, 16)
                
                ScrollView(.horizontal) {
                    HStack( alignment: .top, spacing: 16) {
                        ForEach(row.products) { product in
                            ImageTitleRowCell(
                                imageSize: 120,
                                imageName: product.firstImage,
                                title: product.title
                            )
                            .asButton (.press){
                                
                            }
                        }
                    }
                    //  .background(Color.blue)
                    .padding(.horizontal, 16)
                }
                //.scrollIndicators
                
                // .background(Color.red)
                
            }
        }
    }
}

#Preview {
    HomeView()
}

//
//  HomeView.swift
//  SwiftFulSpotify
//
//  Created by ALYSSON MENEZES on 30/06/25.
//

import SwiftUI
import SwiftfulUI // SDK SwiftFulThinking
import SwiftfulRouting

@Observable // iOS 17+
final class HomeViewModel {
    
    let router: AnyRouter
    
     var currentUser: User? = nil
     var selectedCategory: Category? = nil
     var products: [Product] = []
     var productsRows: [ProductRow] = []
    
    init(router: AnyRouter) {
        self.router = router
        self.currentUser = currentUser
        self.selectedCategory = selectedCategory
        self.products = products
        self.productsRows = productsRows
    }
    
    //MARK: FUNCS
     func getData() async {
        
        guard products.isEmpty else { return }
        
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
    
    @MainActor  func goToPlayListView(product: Product) {
        guard let currentUser else { return }
        
        router.showScreen(.push) {_ in
            PlaylistView(product: product, user: currentUser)
        }
    }
    
    //MARK: COMPONENT GRID DO SDK
     var recentsSection: some View {
        
        NonLazyVGrid(columns: 2, alignment: .center, spacing: 10, items: products) { product in
            if let product {
                RecentsCell(
                    imageName: product.firstImage,
                    title: product.title
                )
                //MARK: SDK SWIFTFULTHINKING
                .asButton (.press){
                    self.goToPlayListView(product: product)
                }
            }
        }
    }
    
}

struct HomeView: View {
    
    @State var viewModel: HomeViewModel
    
    @Environment(\.router) var router
    
//    @State private var currentUser: User? = nil
//    @State private var selectedCategory: Category? = nil
//    @State private var products: [Product] = []
//    @State private var productsRows: [ProductRow] = []
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 1, pinnedViews: [.sectionHeaders], content: {
                    Section {
                        VStack (spacing: 16){
                            viewModel.recentsSection
                                .padding(.horizontal, 16)
                            
                            if let product = viewModel.products.first {
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
            await viewModel.getData()
        }
        .navigationBarHidden(true) // Oculta a barra
        // .toolbar(.hidden, for: .navigationBar) //iOS 16+
    }
    
    

    
    
    //MARK: UI COMPONENTS
    private var header : some View {
        HStack (spacing: 0){
            ZStack {
                if let currentUser = viewModel.currentUser {
                    ImageLoaderView()
                    
                        .background(.spotifyWhite)
                        .clipShape(Circle())
                        .onTapGesture {
                            router.dismissScreen()
                        }
                }
            }
            .frame(width: 40, height: 40)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack (spacing: 8.0) {
                    //MARK: enum com os Itens
                    ForEach(Category.allCases, id: \.self) { category in
                        CategoryCell(title: category.rawValue.capitalized, isSelected: category == viewModel.selectedCategory)
                        //
                            .onTapGesture {
                                viewModel.selectedCategory = category
                            }
                    }
                }
                
                .padding(.horizontal, 16)
            }
            //   .scrollIndicators(.hidden) //ios16+
            .toolbar(.hidden, for: .navigationBar) // iOS 16+
        }
        .padding(.vertical, 24)
        .padding(.leading, 8)
        .frame(maxWidth: .infinity)
        .background(Color.spotifyBlack)
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
                viewModel.goToPlayListView(product: product)
            }
        )
    }
    
    private var listRows: some View {
        ForEach(viewModel.productsRows) { row in
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
                                viewModel.goToPlayListView(product: product)
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
    RouterView {router in
        HomeView(viewModel: HomeViewModel(router: router))
    }
}

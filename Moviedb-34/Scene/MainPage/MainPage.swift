//
//  MainPage.swift
//  Moviedb-34
//
//  Created by gvantsa gvagvalia on 6/5/24.
//

import SwiftUI

struct MainPage: View {
    @State var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab ) {
            
            MoviesListPage()
                .tabItem {
                    (selectedTab == 0 ? Image("HomeIcon") : Image("HomeIcon-Unselected"))
                        .font(UIDevice.current.userInterfaceIdiom == .pad ? .system(size: 100) : .system(size: 20)) // Larger on iPad, smaller on iPhone

                    Text("Movies")
                        .font(UIDevice.current.userInterfaceIdiom == .pad ? .system(size: 20) : .system(size: 14)) // Adjust text size similarly

                }
                .tag(0)
            
            SearchPage(selectedTab: $selectedTab)
                .tabItem {
                    (selectedTab != 1 ? Image("SearchIcon-Unselected") : Image("SearchIcon"))
                        .font(UIDevice.current.userInterfaceIdiom == .pad ? .system(size: 100) : .system(size: 20))

                    Text("Search")
                        .font(UIDevice.current.userInterfaceIdiom == .pad ? .system(size: 20) : .system(size: 14)) // Adjust text size similarly

                }
                .tag(1)
            
            FavouritesPage()
                .tabItem {
                    (selectedTab != 2 ? Image("Save-unselected") : Image("Save-selected"))
                        .font(UIDevice.current.userInterfaceIdiom == .pad ? .system(size: 100) : .system(size: 20))

                    Text("Favourites")
                        .font(UIDevice.current.userInterfaceIdiom == .pad ? .system(size: 20) : .system(size: 14))

                }
                .tag(2)
        }
    }
}

//#Preview {
//    MainPage()
//        .environmentObject(MoviesListPageViewModel())
//        .environmentObject(GenresViewModel())
//}

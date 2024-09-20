//
//  MainPage.swift
//  Moviedb-34
//
//  Created by gvantsa gvagvalia on 6/5/24.
//

import SwiftUI

struct MainPage: View {
    @State var selectedTab = 0
    @EnvironmentObject var moviesListViewModel: MoviesListPageViewModel
    
    var body: some View {
        TabView(selection: $selectedTab ) {
            
            MoviesListPage()
                .tabItem {
                    selectedTab == 0 ? Image("HomeIcon") : Image("HomeIcon-Unselected")
                    Text("Movies")
                }
                .tag(0)
            
            SearchPage(selectedTab: $selectedTab)
                .tabItem {
                    selectedTab != 1 ? Image("SearchIcon-Unselected") : Image("SearchIcon")
                    Text("Search")
                }
                .tag(1)
            
            FavouritesPage()
                .tabItem {
                    selectedTab != 2 ? Image("Save-unselected") : Image("Save-selected")
                    Text("Favourites")
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

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
                    Image(systemName: "movieclapper")
                    Text("Movies")
                }
                .tag(0)
            SearchPage(selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "sparkle.magnifyingglass")
                    Text("Search")
                }
                .tag(1)
        }
    }
}

#Preview {
    MainPage()
        .environmentObject(MoviesListPageViewModel())
    
}

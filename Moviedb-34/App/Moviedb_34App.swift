//
//  Moviedb_34App.swift
//  Moviedb-34
//
//  Created by gvantsa gvagvalia on 6/5/24.
//

import SwiftUI
import SwiftData

@main
struct Moviedb_34App: App {
    @StateObject var moviesListViewModel = MoviesListPageViewModel()
    @StateObject var genresViewModel = GenresViewModel()
    @StateObject var favoritesViewModel = FavouritesPageViewModel()
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environmentObject(moviesListViewModel)
                .environmentObject(genresViewModel)
                .environmentObject(favoritesViewModel)
                .modelContainer(for: FavMoviesModel.self)
        }
        .modelContainer(for: FavMoviesModel.self)
    }
}

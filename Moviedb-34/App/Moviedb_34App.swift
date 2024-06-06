//
//  Moviedb_34App.swift
//  Moviedb-34
//
//  Created by gvantsa gvagvalia on 6/5/24.
//

import SwiftUI

@main
struct Moviedb_34App: App {
    @StateObject var moviesListViewModel = MoviesListPageViewModel()
    var body: some Scene {
        WindowGroup {
            MainPage()
                .environmentObject(moviesListViewModel)
        }
    }
}

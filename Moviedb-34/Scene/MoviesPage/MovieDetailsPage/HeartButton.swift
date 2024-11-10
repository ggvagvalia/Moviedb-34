//
//  HeartButton.swift
//  Moviedb-34
//
//  Created by gvantsa gvagvalia on 11/9/24.
//

import SwiftUI

struct HeartButton: View {
    var movie: Movies
    @EnvironmentObject var favouritesPageViewModel: FavouritesPageViewModel
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VStack {
            Button(action: {
                
                if favouritesPageViewModel.isHearted(movie: movie) {
                    if let heartedMovie = favouritesPageViewModel.favoriteMovies.first(where: { $0.title == movie.title }) {
                        favouritesPageViewModel.removeFavorite(heartedMovie: heartedMovie, context: modelContext)
                    }
                } else {
                    favouritesPageViewModel.addFavorite(movie: movie, context: modelContext)
                }
            }, label: {
                Image(systemName: favouritesPageViewModel.isHearted(movie: movie) ? "heart.fill" : "heart")
                    .foregroundColor(.red)
            })
        }
    }
}

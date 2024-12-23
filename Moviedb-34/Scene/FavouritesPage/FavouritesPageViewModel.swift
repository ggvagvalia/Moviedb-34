//
//  FavouritesPageViewModel.swift
//  Moviedb-34
//
//  Created by gvantsa gvagvalia on 6/8/24.
//

//import SwiftUI
import SwiftData
import Foundation

class FavouritesPageViewModel: ObservableObject {
    @Published var favoriteMovies: [FavMoviesModel] = []
    
    
    func updateFavorites(from movies: [FavMoviesModel]) {
        favoriteMovies = movies
    }
    
    @MainActor
    func isHearted(movie: Movies) -> Bool {
        favoriteMovies.contains { $0.title == movie.title }
    }
    
    
    @MainActor
    func addFavorite(movie: Movies, context: ModelContext) {
        let newAddedMovie = FavMoviesModel(title: movie.title, overview: movie.overview, releaseDate: String(movie.releaseDateFormated), genreIDs: movie.genre_ids, posterPath: movie.poster_path, backdropPath: movie.backdrop_path, voteAverage: Double(movie.vote_count), originalLanguage: movie.original_language)
        context.insert(newAddedMovie)
        favoriteMovies.append(newAddedMovie)
        try? context.save()
    }
    
    func removeFavorite(heartedMovie: FavMoviesModel, context: ModelContext) {
        context.delete(heartedMovie)
        favoriteMovies.removeAll { $0.id == heartedMovie.id}
        try? context.save()
    }
}

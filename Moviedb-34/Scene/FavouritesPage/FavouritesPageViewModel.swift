//
//  FavouritesPageViewModel.swift
//  Moviedb-34
//
//  Created by gvantsa gvagvalia on 6/8/24.
//

import SwiftUI
import SwiftData
import Foundation

final class FavouritesPageViewModel: ObservableObject {
    @Published var favoriteMoviess: [FavMoviesModel] = []
    
    init() {
    }
    
    func updateFavorites(from movies: [FavMoviesModel]) {
        favoriteMoviess = movies
    }
    
    func isHearted(_ movie: FavMoviesModel) -> Bool {
        return favoriteMoviess.contains {$0.title == movie.title}
    }
    
    func addFavorite(_ movie: FavMoviesModel, context: ModelContext) {
        favoriteMoviess.append(movie)
        context.insert(movie)
        try? context.save()
    }
    
    func removeFavorite(_ movie: FavMoviesModel, context: ModelContext) {
        if let index = favoriteMoviess.firstIndex(where: { $0.title == movie.title }) {
            context.delete(favoriteMoviess[index])
            favoriteMoviess.remove(at: index) 
            try? context.save()
        }
    }
    
    func stayHearted(for movie: FavMoviesModel) {
        UserDefaults.standard.set(true, forKey: movie.title)
    }
    
    func loadHeartedState(for movie: FavMoviesModel) -> Bool {
        return UserDefaults.standard.bool(forKey: movie.title)
    }
    
}

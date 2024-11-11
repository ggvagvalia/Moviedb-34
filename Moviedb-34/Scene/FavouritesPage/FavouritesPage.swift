//
//  FavouritesPage.swift
//  Moviedb-34
//
//  Created by gvantsa gvagvalia on 6/8/24.
//

import SwiftUI
import SwiftData

struct FavouritesPage: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject var favorites: FavouritesPageViewModel
    @EnvironmentObject var genresViewModel: GenresViewModel
    @Query private var movies: [FavMoviesModel]
    @State private var isLoading = false
    
    private var genres: [Genres] {
        return genresViewModel.movieGenres
    }
    
    private func filteredGenres(for movie: FavMoviesModel) -> [String] {
        return movie.genreIDs.compactMap { genreId in
            genres.first { $0.id == genreId }?.name
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if isLoading {
                    ProgressView("Loading")
                } else {
                    ScrollView {
                        ForEach(movies, id: \.self) { movie in
                            NavigationLink(value: movie) {
                                MovieSearchView(
                                    image: movie.posterURL,
                                    title: movie.title,
                                    releaseDate: movie.releaseDate,
                                    language: movie.originalLanguage,
                                    rating: movie.formattedVote,
                                    genre: filteredGenres(for: movie),
                                    codableModel: Movies(backdrop_path: movie.backdropPath, genre_ids: movie.genreIDs, id: movie.hashValue, original_language: movie.originalLanguage, overview: movie.overview, poster_path: movie.posterPath, release_date: movie.releaseDate, title: movie.title, vote_average: Double(movie.formattedVote) ?? 0, vote_count: Int(movie.voteAverage)))
                                .listStyle(.grouped)
                                .background(Color.white)
                                .cornerRadius(10)
                                .padding(.bottom, 20)
                            }
                        }
                    }
                    .safeAreaPadding(.leading)
                    .safeAreaPadding(.trailing)
                    .navigationDestination(for: FavMoviesModel.self) { movie in
                        MovieDetailsPage(
                            movieTitle: movie.title,
                            movieDescription: movie.overview,
                            releaseDate: movie.releaseDate,
                            genre: filteredGenres(for: movie),
                            posterImage: movie.posterURL,
                            backdropImage: movie.backdropImageURL,
                            rating: movie.formattedVote,
                            language: movie.originalLanguage,
                            codableModel: Movies(backdrop_path: movie.backdropPath, genre_ids: movie.genreIDs, id: movie.hashValue, original_language: movie.originalLanguage, overview: movie.overview, poster_path: movie.posterPath, release_date: movie.releaseDate, title: movie.title, vote_average: Double(movie.formattedVote) ?? 0, vote_count: Int(movie.voteAverage)))
                        
                    }
                }
            }
            .navigationTitle("Favourites")
        }
        .onAppear {
            favorites.updateFavorites(from: movies)
        }
    }
}

private struct centerView: View {
    var searchedText = ""
    
    var body: some View {
        VStack {
            
            Text("No favourites yet")
                .font(.system(size: 16))
                .bold()
                .padding()
            
            Text("""
                     All moves marked as favourite will be
                    added here
                    """)
            .font(.system(size: 12))
            .padding()
        }
        .multilineTextAlignment(.center)
        .padding()
    }
}

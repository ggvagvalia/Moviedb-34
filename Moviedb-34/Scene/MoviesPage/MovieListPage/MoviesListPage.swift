//
//  MoviesListPage.swift
//  Moviedb-34
//
//  Created by gvantsa gvagvalia on 6/5/24.
//

import SwiftUI

struct MoviesListPage: View {
    @EnvironmentObject var moviesListViewModel: MoviesListPageViewModel
    @EnvironmentObject var genresViewModel: GenresViewModel
    @State private var isLoading = false
    
    @State private var columns: [GridItem] = {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        } else {
            return [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        }
    }()
    
    private var movies: [Movies] {
        return moviesListViewModel.movies
    }
    
    private var genres: [Genres] {
        return genresViewModel.movieGenres
    }
    
    private func filteredGenres(for movie: Movies) -> [String] {
        return movie.genre_ids.compactMap { genreId in
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
                        LazyVGrid(columns: columns) {
                            ForEach(movies, id: \.id) { movie in
                                NavigationLink(value: movie) {
                                    MoviesListView(image: movie.posterURL, title: movie.title)
                                        .padding(.bottom, 20)
                                }
                            }
                        }
                    }
                    .navigationDestination(for: Movies.self) { movie in
                        MovieDetailsPage(movieTitle: movie.title, movieDescription: movie.overview, releaseDate: movie.release_date, genre: filteredGenres(for: movie), posterImage: movie.posterURL, backdropImage: movie.backdropImageURL, rating: movie.formattedVote, language: movie.original_language)
                    }
                    .navigationTitle("Movies")
                    .safeAreaPadding(.leading, 8)
                    .safeAreaPadding(.trailing, 10)
                }
            }
            .onAppear {
                moviesListViewModel.fetchData()
            }
        }
        .foregroundStyle(.black)
    }
}
//
//#Preview {
//    MoviesListPage()
//        .environmentObject(MoviesListPageViewModel())
//}

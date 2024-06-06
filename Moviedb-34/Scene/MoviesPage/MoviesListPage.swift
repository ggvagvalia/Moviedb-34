//
//  MoviesListPage.swift
//  Moviedb-34
//
//  Created by gvantsa gvagvalia on 6/5/24.
//

import SwiftUI

struct MoviesListPage: View {
    @EnvironmentObject var moviesListViewModel: MoviesListPageViewModel
    @State private var isLoading = false
    
    private var movies: [Movies] {
        return moviesListViewModel.movies
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if isLoading {
                    ProgressView("Loading")
                } else {
                    ScrollView {
                        ForEach(movies, id: \.id) { movie in
                            NavigationLink(value: movie) {
                                MoviesListView(image: movie.posterURL, title: movie.title, releaseDate: movie.release_date, language: movie.original_language, rating: movie.formattedVote)
                                    .frame(height: Constants.movieListIpadHeight)
                                    .listStyle(.grouped)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .padding(.bottom, 20)
                            }
                        }
                    }
                    .navigationDestination(for: Movies.self) { movie in
                       Text(movie.title)
                    }
                    .navigationTitle("Popular Movies")
                    .safeAreaPadding(.leading, 9)
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

#Preview {
    MoviesListPage()
        .environmentObject(MoviesListPageViewModel())
}

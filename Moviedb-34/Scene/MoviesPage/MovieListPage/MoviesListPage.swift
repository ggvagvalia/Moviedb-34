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
    @State private var columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
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
                        LazyVGrid(columns: columns) {
                            ForEach(movies, id: \.id) { movie in
                                NavigationLink(value: movie) {
                                    MoviesListView(image: movie.posterURL, title: movie.title, rating: movie.formattedVote)
                                        .frame(height: Constants.movieListIpadHeight)
                                        .listStyle(.grouped)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .padding(.bottom, 20)
                                }
                            }
                        }
                        
                    }
                    .navigationDestination(for: Movies.self) { movie in
                       Text(movie.title)
                    }
                    .navigationTitle("Popular Movies")
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

#Preview {
    MoviesListPage()
        .environmentObject(MoviesListPageViewModel())
}

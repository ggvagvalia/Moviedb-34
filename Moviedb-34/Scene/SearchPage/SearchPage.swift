//
//  SearchPage.swift
//  Moviedb-34
//
//  Created by gvantsa gvagvalia on 6/5/24.
//

import SwiftUI

struct SearchPage: View {
    @EnvironmentObject var moviesListViewModel: MoviesListPageViewModel
    @State private var isLoading = false
    @State private var searchedText = ""
    @Binding var selectedTab: Int

    
    private var filteredMovies: [Movies] {
        return moviesListViewModel.movies.filter { $0.title.localizedCaseInsensitiveContains(searchedText)}
    }
    
    private var movies: [Movies] {
        return moviesListViewModel.movies
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if isLoading {
                    ProgressView("Loading...")
                } else {
                    ScrollView {
                        ForEach(filteredMovies, id: \.id) { movie in
                            MoviesListView(image: movie.posterURL, title: movie.title, releaseDate: movie.release_date, language: movie.original_language, rating: movie.formattedVote)
                                .frame(height: Constants.movieListIpadHeight)
                                .listStyle(.grouped)
                                .background(Color.white)
                                .cornerRadius(10)
                                .padding(.bottom, 20)
                        }
                    }
                    .safeAreaPadding(.leading)
                    .safeAreaPadding(.trailing)
                }
            }
            .onAppear {
                moviesListViewModel.fetchData()
            }
            .navigationTitle("Movies")
        }
        .onChange(of: selectedTab) {
            searchedText = ""
        }
        .searchable(text: $searchedText, placement: .automatic, prompt: "Search Movies")
    }
}


//#Preview {
//    SearchPage()
//        .environmentObject(MoviesListPageViewModel())
//    
//}

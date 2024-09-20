//
//  SearchPage.swift
//  Moviedb-34
//
//  Created by gvantsa gvagvalia on 6/5/24.
//

import SwiftUI

struct SearchPage: View {
    @EnvironmentObject var moviesListViewModel: MoviesListPageViewModel
    @EnvironmentObject var genresViewModel: GenresViewModel
    @State private var isLoading = false
    @State private var searchedText = ""
    @State private var filterCr: FilterBy?
    @State private var isMenuSelected = false
    @Binding var selectedTab: Int
    @Environment(\.colorScheme) var mode
    
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
    
    private var filteredMovies: [Movies] {
        var filteredMovies = moviesListViewModel.movies
        if let chosenFilter = filterCr {
            switch chosenFilter {
            case .title:
                filteredMovies = moviesListViewModel.movies.filter { $0.title.localizedCaseInsensitiveContains(searchedText) }
            case .genre:
                filteredMovies = filteredMovies.filter { movie in
                    let genres = filteredGenres(for: movie)
                    return genres.contains(where: {$0.localizedCaseInsensitiveContains(searchedText)})
                }
            case .year:
                filteredMovies = moviesListViewModel.movies.filter { movie in
                    return "\(movie.releaseDateFormated)".contains(searchedText)
                }
            }
        }
        return filteredMovies
    }
    
    init(selectedTab: Binding<Int>) {
        _selectedTab = selectedTab
        _filterCr = State(initialValue: .title)
    }
    
    
    var body: some View {
        
        NavigationStack {
            VStack {
                HStack {
                    ZStack {
                        HStack {
                            TextField("Search by... →", text: $searchedText)
                                .frame(height: 45)
                            Spacer()
                            Image(mode == .light ? "SearchIcon-Light" : "SearchIcon-Dark")
                                .font(.system(size: 16))
                        }
                    }
                    .padding(.horizontal)
                    .background(Color.searchbackground)
                    .cornerRadius(16)
                    
                    Menu {
                        
                        Button(action: {
                            filterCr = .title
                            searchedText = ""
                        }) {
                            HStack {
                                filterCr == .title ? Image(systemName: "checkmark") : nil
                                Text("Title")
                            }
                        }
                        Button(action: {
                            filterCr = .genre
                            searchedText = ""
                        }) {
                            HStack {
                                filterCr == .genre ? Image(systemName: "checkmark") : nil
                                Text("Genre")
                            }
                        }
                        Button(action: {
                            filterCr = .year
                            searchedText = ""
                        }) {
                            HStack {
                                filterCr == .year ? Image(systemName: "checkmark") : nil
                                Text("Year")
                            }
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .font(.system(size: 25))
                            .foregroundStyle(mode == .light ? .black : .white )
                    }
                }
                .padding()
                
                if !filteredMovies.isEmpty {
                    ScrollView {
                        ForEach(filteredMovies, id: \.id) { movie in
                            MovieSearchView(image: movie.posterURL, title: movie.title, releaseDate: movie.release_date, language: movie.original_language, rating: movie.formattedVote, genre: filteredGenres(for: movie))
                                .listStyle(.grouped)
                                .background(Color.white)
                                .cornerRadius(10)
                                .padding(.bottom, 20)
                        }
                    }
                    .safeAreaPadding(.leading)
                    .safeAreaPadding(.trailing)
                } else {
                    Spacer()
                    
                    centerView(searchedText: searchedText)
                    
                }
                Spacer()
            }
            .onAppear {
                moviesListViewModel.fetchData()
            }
            .navigationTitle("Search")
        }
        .onChange(of: selectedTab) {
            searchedText = ""
        }
    }
    
    enum FilterBy {
        case title
        case genre
        case year
    }
}


private struct centerView: View {
    var searchedText = ""
    
    var body: some View {
        VStack {
            if searchedText.isEmpty {
                
                Text("Use the magic search!")
                    .font(.system(size: 16))
                    .bold()
                    .padding()
                
                Text("""
                     I will do my best to search everything
                     relevant, I promise!
                    """)
                .font(.system(size: 12))
                .padding()
                
            } else {
                
                Text("""
                     oh no isn’t this
                     so embarrassing?
                    """)
                .font(.system(size: 16))
                .bold()
                .padding()
                
                Text("I cannot find any movie with this name.")
                    .font(.system(size: 12))
                    .padding()
            }
        }
        .multilineTextAlignment(.center)
        .padding()
    }
}


#Preview {
    MainPage()
        .environmentObject(MoviesListPageViewModel())
        .environmentObject(GenresViewModel())
}

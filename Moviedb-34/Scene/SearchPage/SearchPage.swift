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
    @EnvironmentObject var favouritesPageViewModel: FavouritesPageViewModel
    
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
                    
                    FilterMenu(filterCr: $filterCr, searchedText: $searchedText, mode: _mode)
                    
                }
                .padding()
                
                if !filteredMovies.isEmpty {
                    ScrollView {
                        ForEach(filteredMovies, id: \.id) { movie in
                            NavigationLink(value: movie) {
                                MovieSearchView(
                                    image: movie.posterURL,
                                    title: movie.title,
                                    releaseDate: movie.release_date,
                                    language: movie.original_language,
                                    rating: movie.formattedVote,
                                    genre: filteredGenres(for: movie), codableModel: movie)
                                .listStyle(.grouped)
                                .background(Color.white)
                                .cornerRadius(10)
                                .padding(.bottom, 20)
                            }
                        }
                    }
                    .safeAreaPadding(.leading)
                    .safeAreaPadding(.trailing)
                    .navigationDestination(for: Movies.self) { movie in
                        MovieDetailsPage(
                            movieTitle: movie.title,
                            movieDescription: movie.overview,
                            releaseDate: movie.release_date,
                            genre: filteredGenres(for: movie),
                            posterImage: movie.posterURL,
                            backdropImage: movie.backdropImageURL,
                            rating: movie.formattedVote,
                            language: movie.original_language,
                            codableModel: movie,
                            favouritesPageViewModel: _favouritesPageViewModel
                        )
                    }
                    
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
        
    }
    
}

struct FilterMenu: View {
    @Binding  var filterCr: FilterBy?
    @Binding  var searchedText: String
    @Environment(\.colorScheme) var mode
    
    var body: some View {
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
}

private struct centerView: View {
    var searchedText = ""
    
    var body: some View {
        VStack {
            if searchedText.isEmpty {
                
                Text("Use the magic search!")
                    .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 26 : 16))

                    .bold()
                    .padding()
                
                Text("""
                     I will do my best to search everything
                     relevant, I promise!
                    """)
                .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 21 : 12))

                .padding()
                
            } else {
                
                Text("""
                     oh no isn’t this
                     so embarrassing?
                    """)
                .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 26 : 16))

                .bold()
                .padding()
                
                Text("I cannot find any movie with this name.")
                    .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 21 : 12))

                    .padding()
            }
        }
        .multilineTextAlignment(.center)
        .padding()
    }
}

enum FilterBy {
    case title
    case genre
    case year
}

#Preview {
    MainPage()
        .environmentObject(MoviesListPageViewModel())
        .environmentObject(GenresViewModel())
}

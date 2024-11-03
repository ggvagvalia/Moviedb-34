//
//  MovieDetailsPage.swift
//  Moviedb-34
//
//  Created by gvantsa gvagvalia on 6/7/24.
//

import SwiftUI
import SwiftData

struct MovieDetailsPage: View {
    var movieTitle: String
    var movieDescription: String
    var releaseDate: String
    var runtime: String?
    var genre: [String]
    var posterImage: URL
    var backdropImage: URL
    var rating: String
    var language: String
    @State var isHearted = false
    @EnvironmentObject var favorites: FavouritesPageViewModel
    @EnvironmentObject var moviesListViewModel: MoviesListPageViewModel
    @Environment(\.modelContext) private var context
    //    @Published var favoriteMoviess: [FavMoviesModel] = []
    
    
    var body: some View {
        VStack {
            VStack {
                BackdropMovieView(backdropImage: backdropImage, rating: rating, posterImage: posterImage, movieTitle: movieTitle)
            }
            
            VStack(spacing: 25) {
                
                AboutMovieHStackView(releaseDate: releaseDate, language: language, genre: genre)
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        Text("About Movie")
                            .font(.system(size: Constants.horizontalSizeClass == .regular ? 27 : 14))
                            .foregroundStyle(Color(uiColor: .label))
                            .padding(.horizontal, 7)
                            .padding(.bottom, 1)
                            .padding(.top)
                            .bold()
                        
                        Spacer()
                        
                        Button(action: {
                            isHearted.toggle()
                            
                            guard let movie = moviesListViewModel.movies.first(where: { $0.title == movieTitle }) else {
                                   return
                               }
                            
                                let heartedMovie = FavMoviesModel(
                                    title: movie.title,
                                    overview: movie.overview,
                                    releaseDate: movie.release_date,
                                    genreIDs: movie.genre_ids,
                                    posterPath: movie.poster_path,
                                    backdropPath: movie.backdrop_path,
                                    voteAverage: movie.vote_average,
                                    originalLanguage: movie.original_language
                                )
                                if isHearted {
                                    if !favorites.isHearted(heartedMovie) {
                                        favorites.addFavorite(heartedMovie, context: context)
                                    }
                                    favorites.stayHearted(for: heartedMovie)
                                    
                                } else {
                                    favorites.removeFavorite(heartedMovie, context: context)
                                }
                            isHearted = favorites.isHearted(heartedMovie)
                            
                        }) {
                            Image(systemName: isHearted ? "heart.fill" : "heart")
                                .foregroundColor(.red)
                        }
                    }
                    
                    DescriptionScrollView(movieDescription: movieDescription)
                    
                }
            }
            .padding()
            .padding(.top, screenHeight * 0.07)
            
        }
        .navigationBarTitle(Text(movieTitle), displayMode: .inline)
        .onAppear {
            if let movie = moviesListViewModel.movies.first(where: { $0.title == movieTitle }) {
                let heartedMovie = FavMoviesModel(
                    title: movie.title,
                    overview: movie.overview,
                    releaseDate: movie.release_date,
                    genreIDs: movie.genre_ids,
                    posterPath: movie.poster_path,
                    backdropPath: movie.backdrop_path,
                    voteAverage: movie.vote_average,
                    originalLanguage: movie.original_language
                )
                isHearted = favorites.loadHeartedState(for: heartedMovie)
            }
        }
    }
}

private struct BackdropMovieView: View {
    var backdropImage: URL
    var rating: String
    var posterImage: URL
    var movieTitle: String
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            ZStack(alignment: .top) {
                ImageView(imageJPG: backdropImage)
                    .frame(width: screenWidth, height: screenHeight * 0.33)
                    .clipShape(
                        .rect(
                            topLeadingRadius: 0,
                            bottomLeadingRadius: 16,
                            bottomTrailingRadius: 16,
                            topTrailingRadius: 0
                        )
                    )
            }
            
            RatingView(rating: rating)
            
            ImageWithTitleView(posterImage: posterImage, movieTitle: movieTitle)
                .offset(y: screenHeight * 0.07)
                .padding(.leading, 32)
        }
    }
}

private struct RatingView: View {
    var rating: String
    
    var body: some View {
        HStack {
            
            Image(systemName: "star")
                .bold()
                .foregroundStyle(.orange)
            
            Text("\(rating)")
                .bold()
                .foregroundStyle(.orange)
        }
        .font(.system(size: Constants.horizontalSizeClass == .regular ? 24 : 12))
        .padding(8)
        .background(.ultraThinMaterial)
        .cornerRadius(15)
        .padding()
    }
}

private struct ImageWithTitleView: View {
    var posterImage: URL
    var movieTitle: String
    
    var body: some View {
        HStack(alignment: .bottom) {
            ImageView(imageJPG: posterImage)
                .frame(width: screenWidth * 0.26, height: screenHeight * 0.17)
                .cornerRadius(10)
            
            Text(movieTitle)
                .font(.system(size: Constants.horizontalSizeClass == .regular ? 29 : 17))
                .foregroundStyle(Color(.label))
                .bold()
                .padding(.leading, 5)
                .padding(.bottom, 2)
            
            Spacer()
        }
    }
}

private struct AboutMovieHStackView: View {
    //    var movieDescription: String
    var releaseDate: String
    var language: String
    var genre: [String]
    //    @Binding var isHearted: Bool
    
    
    var body: some View {
        HStack {
            
            HStack {
                Image("CalendarGray")
                Text(releaseDate.prefix(4))
            }
            
            Text(" | ")
            
            HStack {
                Image(systemName: "character.bubble")
                Text(language)
            }
            
            Text(" | ")
            
            
            HStack {
                
                Image("TicketGray")
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(genre, id: \.self) { genre in
                            Text(genre)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .font(.system(size: Constants.horizontalSizeClass == .regular ? 22 : 12))
        .foregroundStyle(.gray.opacity(0.8))
        .padding(.horizontal, 50)
        
    }
}

private struct DescriptionScrollView: View {
    var movieDescription: String
    
    var body: some View {
        Rectangle()
            .foregroundStyle(.gray.opacity(0.5))
            .frame(maxWidth: .infinity, maxHeight: 4)
        
        ScrollView {
            Text(movieDescription)
                .padding(.horizontal, 7)
                .font(.system(size: Constants.horizontalSizeClass == .regular ? 24 : 12))
                .foregroundStyle(Color(.label))
        }
    }
}



//struct MovieDetailsPage_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailsPage(
//            movieTitle: "Spiderman No Way Home, nono",
//            movieDescription: "A thief who enters the dreams of others to steal secrets from their subconsciousA thief who enters the dreams of others to steal secrets from their subconsciousA thief who enters the dreams of others to steal secrets from their subconsciousA thief who enters the dreams of others to steal secrets from their subconsciousA thief who enters the dreams of others to steal secrets from their subconsciousA thief who enters the dreams of others to steal secrets from their subconscious.",
//            releaseDate: "2010-07-16",
//            runtime: "2h 28min",
//            genre: ["Action", "Adventure", "Sci-Fi"],
//            posterImage: URL(string: "https://image.tmdb.org/t/p/original/gKkl37BQuKTanygYQG1pyYgLVgf.jpg")!,
//            backdropImage: URL(string: "https://image.tmdb.org/t/p/original//fqv8v6AycXKsivp1T5yKtLbGXce.jpg")!,
//            rating: "8.8",
//            language: "En"
//        )
//        .navigationBarTitle(Text("Inception"), displayMode: .inline)
//    }
//
//}

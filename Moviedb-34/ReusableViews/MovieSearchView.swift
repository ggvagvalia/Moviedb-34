//
//  MovieSearchView.swift
//  Moviedb-34
//
//  Created by gvantsa gvagvalia on 6/7/24.
//

import SwiftUI

struct MovieSearchView: View {
    var image: URL
    var title: String
    var releaseDate: String
    var language: String
    var rating: String
    var genre: [String]
    
    var body: some View {
        HStack {
            ImageView(imageJPG: image)
                .frame(width: screenWidth * 0.26, height: screenHeight * 0.18)
                .cornerRadius(16)
            
            VStack(alignment: .leading , spacing: 4) {
                
                TitleView(title: title)
                
                Spacer()
                
                Group {
                    RatingView(rating: rating)
                    
                    GenreView(genre: genre)
                    
                    LanguageView(language: language)
                    
                    ReleaseYearView(releaseDate: releaseDate)
                }
                .font(.system(size: Constants.horizontalSizeClass == .regular ? 24 : 12))
            }
            
        }
        .font(.system(size: 12))
        .foregroundStyle(Color(.label))
        .background(Color(.systemBackground))
    }
    
    private struct TitleView: View {
        var title: String
        
        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                Text(title)
                    .bold()
                    .font(.system(size: Constants.horizontalSizeClass == .regular ? 28 : 16))
                    .truncationMode(.tail)
            }
        }
    }
    
    private struct RatingView: View {
        @Environment(\.colorScheme) var mode
        var rating: String
        
        var body: some View {
            HStack {
                Image(systemName: "star")
                Text("\(rating)")
            }
            .foregroundStyle(.orange)
            .bold()
        }
    }
    
    private struct GenreView: View {
        @Environment(\.colorScheme) var mode
        var genre: [String]
        
        var body: some View {
            HStack {
                
                Image(mode == .light ? "TicketIcon" : "TicketIcon-DarkMode")
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(genre, id: \.self) { genre in
                            Text(genre)
                        }
                    }
                }
            }
        }
    }
    
    private struct LanguageView: View {
        var language: String
        
        var body: some View {
            HStack {
                Image(systemName: "character.bubble")
                    .font(.system(size: 12))
                Text(language)
            }
        }
    }
    
    private struct ReleaseYearView: View {
        @Environment(\.colorScheme) var mode
        var releaseDate: String
        
        var body: some View {
            HStack {
                Image(mode == .light ? "CalendarIcon" : "CalendarIcon-DarkMode")
                Text(releaseDate.prefix(4))
            }
        }
    }
}


//#Preview {
//    MainPage()
//        .environmentObject(MoviesListPageViewModel())
//        .environmentObject(GenresViewModel())
//}

//
//  FamouritesPageModel.swift
//  Moviedb-34
//
//  Created by gvantsa gvagvalia on 6/8/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class FavMoviesModel {
    var title: String
    var overview: String
    var releaseDate: String
    var genreIDs: [Int]
    var posterPath: String
    var backdropPath: String
    var voteAverage: Double
    var originalLanguage: String
    
    init(title: String, overview: String, releaseDate: String, genreIDs: [Int], posterPath: String, backdropPath: String, voteAverage: Double, originalLanguage: String) {
        self.title = title
        self.overview = overview
        self.releaseDate = releaseDate
        self.genreIDs = genreIDs
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.voteAverage = voteAverage
        self.originalLanguage = originalLanguage
    }
    
    var formattedVote: String {
        String(format: "%.1f", voteAverage)
    }
    
    var posterURL: URL {
        return URL(string: "\(Constants.imagePath)\(posterPath)")!
    }
    var backdropImageURL: URL {
        return URL(string: "\(Constants.imagePath)\(backdropPath)")!
    }
    
    var releaseDateFormated: Int {
        let releaseYear = releaseDate.split(separator: "-")
        guard let yearString = releaseYear.first, let year = Int(yearString) else {
            return 0
        }
        return year
    }
}



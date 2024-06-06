//
//  MoviesListModel.swift
//  Moviedb-34
//
//  Created by gvantsa gvagvalia on 6/5/24.
//

import Foundation

struct MoviesListModel: Hashable, Decodable {
    var results: [Movies]
}

struct Movies: Hashable, Decodable {
    var adult: Bool
    var backdrop_path: String
    var genre_ids: [Int]
    var id: Int
    var original_language: String
    var overview: String
    var poster_path: String
    var release_date: String
    var title: String
    var vote_average: Double
    var vote_count: Int
    
    var formattedVote: String {
        String(format: "%.1f", vote_average)
    }
    
    var posterURL: URL {
        return URL(string: "\(Constants.imagePath)\(poster_path)")!
    }
}


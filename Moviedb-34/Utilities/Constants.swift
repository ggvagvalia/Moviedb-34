//
//  Constants.swift
//  Moviedb-34
//
//  Created by gvantsa gvagvalia on 6/6/24.
//

import Foundation
import SwiftUI

struct Constants {
    static let apiKey = "bbc41f31f09dbe8b992311ea057c7b9c"
    static let url = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)"
    static let genresUrl = "https://api.themoviedb.org/3/genre/movie/list?api_key=\(apiKey)"
    static let imagePath = "https://image.tmdb.org/t/p/original/"
    static let movieListIpadHeight: CGFloat? = {
       return UIDevice.current.userInterfaceIdiom == .pad ? 220 : nil
    }()

    // trending Movies API
    // let url = "https://api.themoviedb.org/3/trending/movie/day?api_key=\(apiKey)"
}

//
//  SearchPageModel.swift
//  Moviedb-34
//
//  Created by gvantsa gvagvalia on 6/7/24.
//

import Foundation
import NetworkingNew

final class GenresViewModel: ObservableObject {
    let networking = NetworkingNew.shared
    @Published var movieGenres: [Genres] = []
    
    init() {
        fetchGenres()
    }
    
    func fetchGenres() {
        networking.fetchData(urlString: Constants.genresUrl) { (result: Result<GenreModel, Error>) in
            switch result {
            case.success(let decodedData):
                DispatchQueue.main.async { [weak self] in
                    self?.movieGenres = decodedData.genres
                }
            case .failure(let error):
                print("error decoding data \(error)")
            }
        }
    }
    
    func filterGenres() -> [String] {
        let genreId = movieGenres.map {$0.id}
        return genreId.compactMap { id in
            movieGenres.first { $0.id == id }?.name
        }
    }
    
}

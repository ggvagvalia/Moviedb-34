//
//  MoviesListPageViewModel.swift
//  Moviedb-34
//
//  Created by gvantsa gvagvalia on 6/5/24.
//

import SwiftUI
import NetworkingNew

final class MoviesListPageViewModel: ObservableObject {
    let networking = NetworkingNew.shared
    @Published var movies: [Movies] = []
//    var codableModel: Movies?

    private var isLoading = false
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        networking.fetchData(urlString: Constants.url) { (result: Result<MoviesListModel, Error>) in
            switch result {
            case .success(let decodedData):
                DispatchQueue.main.async { [weak self] in
                    self?.movies = decodedData.results
                    self?.isLoading = false
                }
            case .failure(let error):
                print("error fetching data: \(error)")
            }
        }
    }
}

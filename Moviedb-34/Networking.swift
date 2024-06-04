//
//  Networking.swift
//  Moviedb-34
//
//  Created by gvantsa gvagvalia on 6/5/24.
//

import Foundation

public class NetworkingService {
    
    public static let shared = NetworkingService()
    
    private init() {}
    
    public func fetchData<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            print("Invalid url")
            completion(.failure(NetworkError.invalidURL))
            return
        }
        fetchData(fromURL: url, completion: completion)
    }
    public func fetchData<T: Decodable>(fromURL: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: fromURL) { data, response, error in
            
            if let error = error {
                print("error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("no data")
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                completion(.failure(error))
                print("error decoding json \(error.localizedDescription)")
            }
            
        }.resume()
    }
}



public enum NetworkError: Error {
    case invalidURL
    case noData
}

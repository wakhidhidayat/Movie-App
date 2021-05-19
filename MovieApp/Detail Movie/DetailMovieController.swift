//
//  DetailMovieController.swift
//  MovieApp
//
//  Created by Wahid Hidayat on 18/05/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation

class DetailMovieController {
    var movieId: Int?
    var movie: DetailMovie?
    
    private let networkService = NetworkService()
    
    func getMovie(completion: @escaping () -> Void) {
        guard let id = movieId else { return }
        let urlString = "https://api.themoviedb.org/3/movie/\(id)?api_key=\(Utils.apiKey)&language=\(Utils.language)"
        let url = URL(string: urlString)
        guard let request = networkService.createRequest(url: url!, method: .get) else { return }
        networkService.dataLoader.loadData(using: request) { (data, _, _) in
            guard let data = data else { return }
            let result = self.networkService.decode(to: DetailMovie.self, data: data)
            guard let movieResult = result else { return }
            self.movie = movieResult
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}

//
//  MoviesController.swift
//  MovieApp
//
//  Created by Wahid Hidayat on 18/05/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation

class MoviesController {
    
    private enum MovieCategory {
        case NowPlaying
        case Upcoming
        case Popular
    }
    
    private func getUrl(from category: MovieCategory) -> URL {
        let baseUrl = "https://api.themoviedb.org/3/movie/"
        let queryStrings = "?api_key=67a0767aae42b8d0bfc75f01e4b31df9&language=en-US"
        
        switch category {
        case .NowPlaying: return URL(string: baseUrl + "now_playing" + queryStrings)!
        case .Upcoming: return URL(string: baseUrl + "upcoming" + queryStrings)!
        case .Popular: return URL(string: baseUrl + "top_rated" + queryStrings)!
        }
    }
    
    private let networkService = NetworkService()
    
    private var movieCategory: MovieCategory?
    
    var movies = [[Movie]]()
    
    func getNowPlayingMovies(completion: @escaping () -> Void) {
        movieCategory = MovieCategory.NowPlaying
        let url = getUrl(from: movieCategory!)
        
        guard let request = networkService.createRequest(url: url, method: .get) else { return }
        networkService.dataLoader.loadData(using: request) { (data, _, _) in
            guard let data = data else { return }
            let result = self.networkService.decode(to: MovieResult.self, data: data)
            guard let movieResult = result?.movies else { return }
            self.movies.append(contentsOf: [movieResult])
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func getUpcomingMovies(completion: @escaping () -> Void) {
        movieCategory = MovieCategory.Upcoming
        let url = getUrl(from: movieCategory!)
        
        guard let request = networkService.createRequest(url: url, method: .get) else { return }
        networkService.dataLoader.loadData(using: request) { (data, _, _) in
            guard let data = data else { return }
            let result = self.networkService.decode(to: MovieResult.self, data: data)
            guard let movieResult = result?.movies else { return }
            self.movies.append(contentsOf: [movieResult])
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func getPopularMovies(completion: @escaping () -> Void) {
        movieCategory = MovieCategory.Popular
        let url = getUrl(from: movieCategory!)
        
        guard let request = networkService.createRequest(url: url, method: .get) else { return }
        networkService.dataLoader.loadData(using: request) { (data, _, _) in
            guard let data = data else { return }
            let result = self.networkService.decode(to: MovieResult.self, data: data)
            guard let movieResult = result?.movies else { return }
            self.movies.append(contentsOf: [movieResult])
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
//
//  MoviesViewController.swift
//  MovieApp
//
//  Created by Wahid Hidayat on 17/05/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var movieTable: UITableView!
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTable.register(MovieTableViewCell.nib(), forCellReuseIdentifier: MovieTableViewCell.identifier)
        movieTable.dataSource = self
        movieTable.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        fetchMovies()
    }
    
    private func fetchMovies() {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/movie/now_playing"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: "67a0767aae42b8d0bfc75f01e4b31df9"),
            URLQueryItem(name: "language", value: "en-US")
        ]
        
        let request = URLRequest(url: components.url!.absoluteURL)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse =
                  response as? HTTPURLResponse,
                  httpResponse.statusCode >= 200 && httpResponse.statusCode < 300
            else {
                return
            }
            
            guard let data = data, error == nil else {
                return
            }
            
            var result: MovieResult?
            
            do {
                result = try JSONDecoder().decode(MovieResult.self, from: data)
            } catch {
                print("Error when decode json!")
            }
            
            guard let finalResult = result else {
                return
            }
            
            let movieResult = finalResult.movies
            self.movies.append(contentsOf: movieResult)
            
            DispatchQueue.main.async {
                self.movieTable.reloadData()
            }
        }.resume()

    }
}

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as? MovieTableViewCell
        cell?.configure(with: movies)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
}

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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let moviesController = MoviesController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTable.register(MovieTableViewCell.nib(), forCellReuseIdentifier: MovieTableViewCell.identifier)
        movieTable.dataSource = self
        movieTable.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        getMovies()
    }
    
    private func getMovies() {
        activityIndicator.startAnimating()
        
        moviesController.getNowPlayingMovies {
            self.movieTable.reloadData()
            
            self.moviesController.getUpcomingMovies {
                self.movieTable.reloadData()
                
                self.moviesController.getPopularMovies {
                    self.movieTable.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
}

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesController.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as? MovieTableViewCell
        cell?.configure(with: moviesController.movies[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230.0
    }
}

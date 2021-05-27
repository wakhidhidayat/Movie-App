//
//  SearchMovieViewController.swift
//  MovieApp
//
//  Created by Wahid Hidayat on 20/05/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import UIKit

class SearchMovieViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let searchMovieController = SearchMovieController()
    private lazy var favoriteProvider: FavoriteProvider = { return FavoriteProvider() }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        tableView.register(SearchMovieTableViewCell.nib(), forCellReuseIdentifier: SearchMovieTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        self.tableView.separatorStyle = .none
    }
    
}

extension SearchMovieViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchMovieController.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchMovieTableViewCell.identifier,
            for: indexPath) as? SearchMovieTableViewCell
        cell?.configure(with: searchMovieController.movies[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailMovieVC = DetailMovieViewController()
        let movieId = searchMovieController.movies[indexPath.row].id
        detailMovieVC.detailMovieController.movieId = movieId
        detailMovieVC.isInFavorites = favoriteProvider.checkDataExistence(movieId)
        navigationController?.pushViewController(detailMovieVC, animated: true)
    }
    
}

extension SearchMovieViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            tableView.separatorStyle = .none
            activityIndicator.stopAnimating()
            searchMovieController.movies.removeAll()
            tableView.reloadData()
        } else {
            searchMovieController.movies.removeAll()
            searchMovieController.query = searchText.replacingOccurrences(of: " ", with: "%20")
            activityIndicator.startAnimating()
            searchMovieController.getMovies {
                self.tableView.separatorStyle = .singleLine
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
            
        }
    }
    
}

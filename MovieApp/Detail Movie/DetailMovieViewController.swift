//
//  DetailMovieViewController.swift
//  MovieApp
//
//  Created by Wahid Hidayat on 18/05/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import UIKit
import Kingfisher

class DetailMovieViewController: UIViewController {
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var backdrop: UIImageView!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var segmentedView: UIView!
    
    let detailMovieController = DetailMovieController()
    var views = [UIView]()
    private lazy var favoriteProvider: FavoriteProvider = { return FavoriteProvider() }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setSegmentedViewAppear()
    }
    
    private func configure(with movie: DetailMovie) {
        movieTitle.text = movie.title
        rating.text = "\(movie.rating)/10"
        releaseDate.text = Utils.formatDate(from: movie.releaseDate)
        
        if let posterUrl = movie.posterUrl {
            poster.kf.setImage(with: URL(string: Utils.baseImageUrl + posterUrl))
        }
        if let backdropUrl = movie.backdropUrl {
            backdrop.kf.setImage(with: URL(string: Utils.baseImageUrl + backdropUrl))
        }
        
        var genresArr = [String]()
        for genre in movie.genres {
            genresArr.append(genre.name)
        }
        genres.text = genresArr.joined(separator: ", ")
    }
    
    private func setupView() {
        let addToFavoritesButton = UIBarButtonItem(
            image: UIImage(systemName: "suit.heart"), style: .plain, target: self, action: #selector(addToFavorites))
        self.navigationItem.rightBarButtonItem = addToFavoritesButton
        
        activityIndicator.startAnimating()
        
        let overviewVC = OverviewViewController()
        let reviewsVC = setupReviewsVC()
        
        detailMovieController.getMovie {
            if let movie = self.detailMovieController.movie {
                self.configure(with: movie)
                overviewVC.overview.text = movie.overview
                self.activityIndicator.stopAnimating()
            }
        }
        
        views.append(overviewVC.view)
        views.append(reviewsVC.view)
        
        for viewControllerView in views {
            segmentedView.addSubview(viewControllerView)
        }
    }
    
    private func setupReviewsVC() -> UIViewController {
        let reviewsVC = ReviewsViewController()
        
        detailMovieController.getReviews {
            reviewsVC.tableView.register(
                ReviewTableViewCell.nib(),
                forCellReuseIdentifier: ReviewTableViewCell.identifier
            )
            reviewsVC.tableView.dataSource = self
            reviewsVC.tableView.delegate = self
            reviewsVC.tableView.reloadData()
        }
        return reviewsVC
    }
    
    @objc private func addToFavorites() {
        let movie = detailMovieController.movie
        
        favoriteProvider.createFavorite(
            movie!.id,
            movieTitle.text!,
            (backdrop.image?.jpegData(compressionQuality: 0.0))!,
            (poster.image?.jpegData(compressionQuality: 0.0))!,
            (movie?.overview)!,
            releaseDate.text!,
            rating.text!,
            genres.text ?? "") {
            
            DispatchQueue.main.async {
                self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "suit.heart.fill")
            }
        }
    }
    
    @IBAction func segmentedValueChanged(_ sender: UISegmentedControl) {
        setSegmentedViewAppear()
    }
    
    private func setSegmentedViewAppear() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            segmentedView.bringSubviewToFront(views[0])
        case 1:
            segmentedView.bringSubviewToFront(views[1])
        default:
            return
        }
    }
}

extension DetailMovieViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailMovieController.reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ReviewTableViewCell.identifier,
            for: indexPath
        ) as? ReviewTableViewCell
        cell?.configure(with: detailMovieController.reviews[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(130.0)
    }
    
}

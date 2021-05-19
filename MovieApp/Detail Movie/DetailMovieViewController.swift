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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setSegmentedViewAppear()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    private func configure(with movie: DetailMovie) {
        movieTitle.text = movie.title
        rating.text = String(movie.rating)
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
        let overviewVC = OverviewViewController()
        activityIndicator.startAnimating()
        detailMovieController.getMovie {
            if let movie = self.detailMovieController.movie {
                overviewVC.overview.text = movie.overview
                self.configure(with: movie)
                self.activityIndicator.stopAnimating()
            }
        }
        views.append(overviewVC.view)
        for viewControllerView in views {
            segmentedView.addSubview(viewControllerView)
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

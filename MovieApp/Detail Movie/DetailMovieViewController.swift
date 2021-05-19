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
    
    let detailMovieController = DetailMovieController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        activityIndicator.startAnimating()
        detailMovieController.getMovie {
            if let movie = self.detailMovieController.movie {
                self.configure(with: movie)
                self.activityIndicator.stopAnimating()
            }
        }
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
    
}

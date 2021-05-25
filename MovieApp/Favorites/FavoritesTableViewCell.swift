//
//  FavoritesTableViewCell.swift
//  MovieApp
//
//  Created by Wahid Hidayat on 25/05/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var poster: UIImageView!

    static let identifier = "FavoritesTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func configure(with movie: Favorite) {
        self.movieTitle.text = movie.title
        self.releaseDate.text = movie.releaseDate
        self.rating.text = movie.rating
        guard let moviePoster = movie.poster else { return }
        poster.image = UIImage(data: moviePoster)
    }

}

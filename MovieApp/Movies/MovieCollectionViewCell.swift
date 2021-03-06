//
//  MovieCollectionViewCell.swift
//  MovieApp
//
//  Created by Wahid Hidayat on 17/05/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var poster: UIImageView!
    
    static let identifier = "MovieCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func configure(with movie: Movie) {
        guard let moviePoster = movie.poster else { return }
        guard let movieUrl = URL(string: Utils.baseImageUrl + moviePoster) else { return }
        poster.kf.setImage(with: movieUrl)
    }
    
}

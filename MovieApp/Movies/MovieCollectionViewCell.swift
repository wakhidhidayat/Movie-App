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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.poster.layer.cornerRadius = 8
        self.poster.clipsToBounds = true
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func configure(with movie: Movie) {
        guard let moviePoster = movie.poster else {
            return
        }
        let imageData = Utils.getImageData(from: moviePoster)
        if let data = imageData {
            self.poster.image = UIImage(data: data)
        }
    }
    
}

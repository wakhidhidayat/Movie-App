//
//  NowPlayingCollectionViewCell.swift
//  MovieApp
//
//  Created by Wahid Hidayat on 17/05/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import UIKit

class NowPlayingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var poster: UIImageView!
    
    static let identifier = "NowPlayingCollectionViewCell"

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
        let posterUrl = URL(string: "https://image.tmdb.org/t/p/w500/\(moviePoster)")
        if let data = try? Data(contentsOf: posterUrl!) {
            self.poster.image = UIImage(data: data)
        }
    }

}

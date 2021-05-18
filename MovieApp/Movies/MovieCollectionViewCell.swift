//
//  MovieCollectionViewCell.swift
//  MovieApp
//
//  Created by Wahid Hidayat on 17/05/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backdrop: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    static let identifier = "MovieCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backdrop.layer.cornerRadius = 8
        self.backdrop.clipsToBounds = true
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func configure(with movie: Movie) {
        self.title.text = movie.title
        guard let movieBackdrop = movie.backdrop else {
            return
        }
        let imageData = Utils.getImageData(from: movieBackdrop)
        if let data = imageData {
            self.backdrop.image = UIImage(data: data)
        }
    }

}

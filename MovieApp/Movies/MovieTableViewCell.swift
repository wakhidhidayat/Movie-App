//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by Wahid Hidayat on 17/05/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    static let identifier = "MovieTableViewCell"
    var movies = [Movie]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(
            MovieCollectionViewCell.nib(),
            forCellWithReuseIdentifier: MovieCollectionViewCell.identifier
        )
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func configure(with models: [Movie]) {
        self.movies = models
        collectionView.reloadData()
    }
    
}

extension MovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieCollectionViewCell.identifier,
            for: indexPath
        ) as? MovieCollectionViewCell
        cell?.configure(with: movies[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let navCon = self.window?.rootViewController as? UINavigationController {
            if let moviesVC = navCon.visibleViewController as? MoviesViewController {
                let detailMovieVC = DetailMovieViewController(nibName: "DetailMovieViewController", bundle: nil)
                detailMovieVC.detailMovieController.movieId = movies[indexPath.row].id
                moviesVC.navigationController?.pushViewController(detailMovieVC, animated: true)
            }
        }
    }
}

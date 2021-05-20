//
//  ReviewTableViewCell.swift
//  MovieApp
//
//  Created by Wahid Hidayat on 20/05/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var reviewBody: UILabel!
    
    static let identifier = "ReviewTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func configure(with review: Review) {
        self.reviewBody.text = review.content
    }
    
}

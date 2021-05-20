//
//  Review.swift
//  MovieApp
//
//  Created by Wahid Hidayat on 20/05/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation

struct ReviewResult: Codable {
    let reviews: [Review]
    
    enum CodingKeys: String, CodingKey {
        case reviews = "results"
    }
}

struct Review: Codable {
    let id: String
    let content: String
}

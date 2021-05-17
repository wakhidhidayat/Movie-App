//
//  Movie.swift
//  MovieApp
//
//  Created by Wahid Hidayat on 17/05/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation

struct MovieResult: Codable {
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movie: Codable {
    let id: Int
    let title: String
    let poster: String?
    let backdrop: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case poster = "poster_path"
        case backdrop = "backdrop_path"
    }
}

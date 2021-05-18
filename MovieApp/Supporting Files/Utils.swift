//
//  Utils.swift
//  MovieApp
//
//  Created by Wahid Hidayat on 17/05/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation

struct Utils {
    
    static func getImageData(from imageString: String) -> Data? {
        guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500/\(imageString)") else {
            return nil
        }
        let data = try? Data(contentsOf: imageUrl)
        return data ?? nil
    }
}

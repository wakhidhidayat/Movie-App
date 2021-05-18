//
//  NetworkLoader.swift
//  MovieApp
//
//  Created by Wahid Hidayat on 18/05/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation

protocol NetworkLoader {
    func loadData(using request: URLRequest, with completion: @escaping (Data?, HTTPURLResponse?, Error?) -> Void)
}

extension URLSession: NetworkLoader {
    func loadData(using request: URLRequest, with completion: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
        self.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Networking error with \(String(describing: request.url?.absoluteString)): \n\(error)")
            }
            
            if let response = response as? HTTPURLResponse {
                let statusCode = response.statusCode
                if statusCode != 200 {
                    print("Bad status code: \(statusCode)")
                }
            }
            
            completion(data, response as? HTTPURLResponse, error)
        }.resume()
    }
}

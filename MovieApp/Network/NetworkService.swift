//
//  NetworkService.swift
//  MovieApp
//
//  Created by Wahid Hidayat on 18/05/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation

class NetworkService {
    /// Used to set a`URLRequest`'s HTTP Method
    enum HttpMethod: String {
        case get = "GET"
        case patch = "PATCH"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    /// Used when the endpoint requires a header-type (i.e. "content-type") be specified in the header
    enum HttpHeaderType: String {
        case contentType = "Content-Type"
    }
    
    /// The value of the header-type (i.e. "application/json")
    enum HttpHeaderValue: String {
        case json = "application/json"
    }
    
    /// used to switch between live and Mock Data
    var dataLoader: NetworkLoader
    
    init(dataLoader: NetworkLoader = URLSession.shared) {
        self.dataLoader = dataLoader
    }
    
    /// Create a request given a URL and requestMethod (get, post, create, etc...)
    func createRequest(
        url: URL?, method: HttpMethod,
        headerType: HttpHeaderType? = nil,
        headerValue: HttpHeaderValue? = nil
    ) -> URLRequest? {
        guard let requestUrl = url else {
            NSLog("request URL is nil")
            return nil
        }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = method.rawValue
        if let headerType = headerType,
           let headerValue = headerValue {
            request.setValue(headerValue.rawValue, forHTTPHeaderField: headerType.rawValue)
        }
        return request
    }
    
    func decode<T: Decodable>(to type: T.Type, data: Data) -> T? {
        let decoder = JSONDecoder()
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Error Decoding JSON into \(String(describing: type)) Object \(error)")
            return nil
        }
    }
    
    func encode<T: Encodable>(from instance: T, request: URLRequest) -> URLRequest? {
        let jsonEncoder = JSONEncoder()
        var request = request
        
        do {
            request.httpBody = try jsonEncoder.encode(instance)
            return request
        } catch {
            print("Error encoding object into JSON \(error)")
            return nil
        }
        
    }
    
}

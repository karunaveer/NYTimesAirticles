//
//  APIClient.swift
//  NYTimesAirticles
//
//  Created by Karunanithi on 24/07/19.
//  Copyright © 2019 Karunanithi. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(Error)
}

enum APIError :Error {
    case unknown, badResponse,jsonDecoder
}

protocol APIClient {
    var session : URLSession { get }
    func get<T:Codable>(with request:URLRequest,handler :@escaping (Result<T>) -> ())
}

extension APIClient {
    
    var session : URLSession {
        return URLSession.shared
    }
    
    func get<T:Codable>(with request:URLRequest,handler :@escaping (Result<T>) -> ()) {
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else { handler(.error(error!)) ; return}
            
            guard let response = response as? HTTPURLResponse , 200..<300 ~= response.statusCode else {handler(.error(APIError.badResponse)); return}
            if let data = data, let strData = String(data: data, encoding: .utf8) {
                print("Response:\n\(strData)")
            }
            guard let value = try? JSONDecoder().decode(T.self, from: data!) else { handler(.error(APIError.jsonDecoder)); return}
            
            handler(.success(value))
            
        } ; task.resume()
    }
}

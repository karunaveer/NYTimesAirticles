//
//  Endpoint.swift
//  NYTimesAirticles
//
//  Created by Karunanithi on 24/07/19.
//  Copyright © 2019 Karunanithi. All rights reserved.
//

import Foundation

protocol Endpoint {
    var baseUrl : String { get }
    var path : String { get }
    var urlParameters : [URLQueryItem] { get }
}

extension Endpoint {
    
    var urlComonent : URLComponents {
        var urlComponent = URLComponents(string: baseUrl)
        urlComponent?.path = path
        urlComponent?.queryItems = urlParameters
        return urlComponent!
    }
    var request : URLRequest {
        return URLRequest(url: urlComonent.url!)
    }
}


enum Order :String {
    case latest, popular, oldest
}

enum AirticleEndpoint: Endpoint {
    case airticles(apiKey: String)
    
    var baseUrl: String {
        return "https://api.nytimes.com"
    }
    var path: String {
        switch self {
        case .airticles:
            return "/svc/mostpopular/v2/viewed/7.json"
        }
    }
    var urlParameters: [URLQueryItem] {
        switch self {
        case .airticles(let apiKey):
            return [
                URLQueryItem(name: "api-key", value: apiKey),
            ]
        }
    }
}

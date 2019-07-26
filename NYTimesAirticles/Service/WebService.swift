//
//  AirticleClient.swift
//  NYTimesAirticles
//
//  Created by Karunanithi on 24/07/19.
//  Copyright © 2019 Karunanithi All rights reserved.
//

import Foundation

/// This service provides interfaces for communication between client and server
class AirticleClient : APIClient {
    
    static let shared = AirticleClient()

    static let apiKey = "Z7xYFFPkVNOvW6AfkLctbPp6jFwC5ZUM"
    
    func fetch(with endpoint:AirticleEndpoint,completion : @escaping (Result<APIResponse>)->()) {
        
        let request = endpoint.request
        
        get(with: request, handler: completion)
    }
}

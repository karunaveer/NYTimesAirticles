//
//  AirticleListController.swift
//  NYTimesAirticles
//
//  Created by Karunanithi on 24/07/19.
//  Copyright © 2019 Karunanithi All rights reserved.
//

import Foundation

class AirticleListController {
    let viewModel: AirticleListViewModel
    
    init(viewModel: AirticleListViewModel = AirticleListViewModel()) {
        self.viewModel = viewModel
    }
    
    func start() {
        self.viewModel.isLoading.value = true
        self.viewModel.isTableViewHidden.value = true
        
        let endPoint = AirticleEndpoint.airticles(apiKey: AirticleClient.apiKey)
        AirticleClient.shared.fetch(with: endPoint ) { [weak self] (result) in
            self?.viewModel.isLoading.value = false
            
            switch result {
            case .error(let error) :
                self?.viewModel.errorMsg.value = error.localizedDescription
                
            case .success(let airticles) :
                if (airticles.results.count > 0){
                    self?.viewModel.isTableViewHidden.value = false
                    self?.viewModel.rowViewModels.value = airticles.results
                }
            }
        }
    }
}

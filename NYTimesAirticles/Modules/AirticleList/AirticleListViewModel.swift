//
//  AirticleListViewModel.swift
//  NYTimesAirticles
//
//  Created by Karunanithi on 24/07/19.
//  Copyright © 2019 Karunanithi All rights reserved.
//

import Foundation
import UIKit

class AirticleListViewModel {
    let isLoading = Observable<Bool>(value: false)
    let isTableViewHidden = Observable<Bool>(value: false)
    let rowViewModels = Observable<[RowViewModel]>(value: [])
    let errorMsg = Observable<String>(value: "")
    
}

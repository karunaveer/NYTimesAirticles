//
//  CellConfigurable.swift
//  NYTimesAirticles
//
//  Created by Karunanithi on 24/07/19.
//  Copyright © 2019 Karunanithi All rights reserved.
//

import Foundation
import UIKit

protocol CellConfigurable {
    func setup(viewModel: RowViewModel?)
}

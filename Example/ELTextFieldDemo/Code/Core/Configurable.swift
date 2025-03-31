//
//  Configurable.swift
//  ELTextFieldDemo
//
//  Created by viktor.volkov on 26.03.2023.
//  Copyright © 2023 E-legion. All rights reserved.
//

import Foundation

@MainActor
protocol Configurable {
    associatedtype Model
    
    func set(model: Model)
}

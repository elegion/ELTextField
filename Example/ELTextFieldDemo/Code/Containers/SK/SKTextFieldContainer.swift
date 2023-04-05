//
//  SKTextFieldContainer.swift
//  ELTextFieldDemo
//
//  Created by viktor.volkov on 05.04.2023.
//  Copyright © 2023 E-legion. All rights reserved.
//

import Foundation
import ELTextField

final class SKTextFieldContainer: ELDefaultTextFieldGenericContainer<SKTextFieldConfiguration> {
    
}

extension SKTextFieldContainer: Configurable {
    
    func set(model: ELDefaultTextFieldBehavior) {
        setBehavior(model)
    }
}

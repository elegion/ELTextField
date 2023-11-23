//
//  BaseTextFieldConfiguration.swift
//  ELTextFieldDemo
//
//  Created by viktor.volkov on 14.06.2023.
//  Copyright © 2023 E-legion. All rights reserved.
//

import Foundation
import ELTextField

enum BaseTextFieldConfiguration: ELTextFieldConfigurationProtocol {
    
    static func layer(for state: ELTextField.ELTextFieldState) -> ELTextField.ELTextInputLayerConfiguration {
        .init(borderColor: .black, borderWidth: 1, cornerRadius: 2, tintColor: .black)
    }
}

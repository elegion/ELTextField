//
//  TLTextFieldConfiguration.swift
//  ELTextFieldDemo
//
//  Created by viktor.volkov on 03.04.2023.
//  Copyright © 2023 E-legion. All rights reserved.
//

import Foundation
import ELTextField
import UIKit

enum TLTextFieldConfiguration: ELTextFieldConfigurationProtocol {
    
    static func layer(for state: ELTextField.ELTextFieldState) -> ELTextField.ELTextInputLayerConfiguration {
        let borderColor: UIColor?
        switch state {
        case .default, .disabled:
            borderColor = R.color.gray919195()
        case .error:
            borderColor = .red
        case .editing:
            borderColor = .black
        }
        return .init(borderColor: borderColor, borderWidth: 1, cornerRadius: 8, tintColor: .white)
    }
    
    static func rect() -> ELTextField.ELTextInputRectConfiguration {
        .init(textInset: UIEdgeInsets(value: 16),
              containerHeight: .init(singleline: 60, multiline: 120))
    }
}

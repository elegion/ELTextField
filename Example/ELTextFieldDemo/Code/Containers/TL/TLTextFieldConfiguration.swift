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
        let tintColor: UIColor?
        switch state {
        case .default, .disabled:
            borderColor = R.color.gray919195()
            tintColor = R.color.black1F22229()
        case .error:
            borderColor = .red
            tintColor = .red
        case .editing:
            borderColor = .black
            tintColor = R.color.black1F22229()
        }
        return .init(borderColor: borderColor, borderWidth: 1, cornerRadius: 8, tintColor: tintColor)
    }
    
    static func rect() -> ELTextField.ELTextInputRectConfiguration {
        .init(textInset: UIEdgeInsets(top: 30, bottom: 8, horizontal: 16),
              rightViewPosition: .centerHorizontally(rightInset: 16, size: CGSize(value: 32)),
              containerHeight: .init(singleline: 60, multiline: 120))
    }
}

//
//  PNFloatingPlaceholderTextFiedConfiguration.swift
//  ELTextFieldDemo
//
//  Created by viktor.volkov on 25.03.2023.
//  Copyright © 2023 E-legion. All rights reserved.
//

import Foundation
import ELTextField
import UIKit
import Swissors

enum PNFloatingPlaceholderTextFieldConfiguration: ELTextFieldConfigurationProtocol {
    
    static func layer(for state: ELTextField.ELTextFieldState) -> ELTextField.ELTextInputLayerConfiguration {
        .init(borderColor: nil, borderWidth: .zero, cornerRadius: .zero, tintColor: R.color.grayBBBBBF())
    }
    
    static func rect() -> ELTextField.ELTextInputRectConfiguration {
        .init(textInset: UIEdgeInsets(top: 26, bottom: 12, horizontal: 16),
              rightViewPosition: .centerHorizontally(rightInset: 20, size: CGSize(value: 12)),
              intrinsicHeight: .init(singleline: 60))
    }
}

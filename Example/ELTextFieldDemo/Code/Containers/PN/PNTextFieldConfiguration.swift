//
//  PNFloatingPlaceholderTextFiedConfiguration.swift
//  ELTextFieldDemo
//
//  Created by viktor.volkov on 25.03.2023.
//  Copyright © 2023 E-legion. All rights reserved.
//

import ELTextField
import Foundation
import Swissors
import UIKit

enum PNTextFieldConfiguration: ELTextFieldConfigurationProtocol {

    static func layer(for state: ELTextField.ELTextFieldState) -> ELTextField.ELTextInputLayerConfiguration {
        .init(borderColor: nil,
              borderWidth: .zero,
              cornerRadius: .zero,
              tintColor: R.color.grayBBBBBF())
    }

    static func rect() -> ELTextField.ELTextInputRectConfiguration {
        .init(
            textInset: UIEdgeInsets(top: 26, bottom: 12, horizontal: 16),
            rightViewPosition: .centerHorizontally(rightInset: 20, size: CGSize(value: 40)),
            containerHeight: .init(value: 60)
        )
    }
}

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
	
	static func caretRect() -> ELTextField.ELCaretRect {
		.default
	}
    
    static func layer(for state: ELTextField.ELTextFieldState) -> ELTextField.ELTextInputLayerConfiguration {
        .init(
			borderColor: .black,
			borderWidth: 1,
			cornerRadius: 2,
			tintColor: .black,
			caretColor: .black,
			backgroundColor: .clear
		)
    }
    
    static func rect() -> ELTextField.ELTextInputRectConfiguration {
        .init(textInset: .zero,
              editingInset: .zero,
              rightViewPosition: nil,
              containerHeight: .init(value: 60))
    }
}

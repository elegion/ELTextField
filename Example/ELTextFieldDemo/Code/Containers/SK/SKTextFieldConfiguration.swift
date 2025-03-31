//
//  SKTextFieldConfiguration.swift
//  ELTextFieldDemo
//
//  Created by viktor.volkov on 05.04.2023.
//  Copyright © 2023 E-legion. All rights reserved.
//

import Foundation
import ELTextField
import UIKit
import Swissors

enum SKTextFieldConfiguration: ELTextFieldConfigurationProtocol {
	
	static func caretRect() -> ELTextField.ELCaretRect {
		.default
	}
	
    
    static func layer(for state: ELTextField.ELTextFieldState) -> ELTextField.ELTextInputLayerConfiguration {
        let color: UIColor = (state == .default) ? UIColor.gray : UIColor.blue
		return .init(
			borderColor: color,
			borderWidth: 1,
			cornerRadius: 8,
			tintColor: .red,
			caretColor: .black,
			backgroundColor: .clear
		)
    }
    
    static func rect() -> ELTextField.ELTextInputRectConfiguration {
        .init(
			textInset: .init(top: 12, left: 16, bottom: 12, right: .zero),
			  rightViewPosition: .centerHorizontally(inset: 16, size: CGSize(value: 24)) ,containerHeight: .init(singleline: 48, multiline: 160))
    }
}

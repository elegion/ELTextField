//
//  ELRightViewMode.swift
//  
//
//  Created by viktor.volkov on 21.09.2023.
//

import Foundation
import UIKit

/// Протокол для создания кастомного поведения правой иконки
public protocol ELRightViewMode: AnyObject {
    
    func initialContainer(textInput: ELTextInput) -> ELRightViewContainer
    func textInput(
        _ textInput: ELTextInput?,
        containerForState state: ELTextFieldState
    ) -> ELRightViewContainer
}

/// Протокол для создания кастомного поведения левой иконки
public protocol ELLeftViewMode: AnyObject {
    
    func initialContainer(textInput: ELTextInput) -> ELLeftViewContainer
    func textInput(
        _ textInput: ELTextInput?,
        containerForState state: ELTextFieldState
    ) -> ELLeftViewContainer
}

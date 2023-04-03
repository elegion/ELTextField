//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation

public enum ELBehaviorAction {
    case changed(newValue: String)
    case endEditing
    case `return`
    case tapOnDisabled
}

public protocol ELTextFieldBehavior: ELTextInputDelegate {
    var mask: ELTextFieldInputMask { get }
    var traits: ELTextFieldInputTraits { get }
    var validation: ELTextFieldValidation { get }
    var placeholder: String? { get }
    var value: String { get }
    var isValid: Bool { get }

    var onAction: ((ELBehaviorAction) -> Void)? { get set }
    var containerDelegate: ELContainerDelegate? { get set }

    func configure(textInput: ELTextInput & ELTextInputConfigurable)
    func updateState(_ state: ELTextFieldState)
    func updateText(_ newText: String?)
}

//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation

public enum BehaviorAction {
    case changed(newValue: String)
    case endEditing
    case `return`
    case tapOnDisabled
}

public protocol ELTextFieldBehavior: ELTextInputOutput {
    var mask: ELTextFieldInputMask { get }
    var traits: ELTextFieldInputTraits { get }
    var validator: ELTextFieldValidator { get }
    var viewModel: ELTextInputViewModel { get }

    var isValid: Bool { get }

    var onAction: ((BehaviorAction) -> Void)? { get set }

    func configure(textInput: ELTextInput & ELTextInputConfigurable)
    func updateState(_ state: ELTextFieldState)
    func updateText(_ newText: String?)
}
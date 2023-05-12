//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation

/// Действия, которые могут произойти с Behavior
public enum ELBehaviorAction {
    /// Текст был изменен
    case changed(newValue: String)
    /// Ввод завершен
    case endEditing
    /// Нажатие на `return`
    case `return`
    /// Нажатие на текстфилд, который находится в disabled состоянии
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

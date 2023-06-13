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

/// Хранит состояние поля ввода
public protocol ELTextFieldBehavior: ELTextInputDelegate {
    
    /// Маска поля ввода
    var mask: ELTextFieldInputMask { get }
    /// Настройки ввода
    var traits: ELTextFieldInputTraits { get }
    /// Логика валидации поля ввода
    var validation: ELTextFieldValidation { get }
    /// Текст плейсхолдера
    var placeholder: String? { get }
    /// Текущее значение поля ввода
    var value: String { get }
    /// Флаг, указывающий, является ли поле валидным
    var isValid: Bool { get }
    
    /// Срабатывает при срабатывании событий поля ввода
    var onAction: ((ELBehaviorAction) -> Void)? { get set }
    /// Используется для обработки дополнительных событий делегата
    var containerDelegate: ELContainerDelegate? { get set }

    func configure(textInput: ELTextInput & ELTextInputConfigurable)
    func updateState(_ state: ELTextFieldState)
    func updateText(_ newText: String?)
}

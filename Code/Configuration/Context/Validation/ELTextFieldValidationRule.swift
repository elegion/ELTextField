//
//  File.swift
//  
//
//  Created by viktor.volkov on 12.05.2023.
//

import Foundation

/// Правило срабатывания валидации поля ввода
public enum ELTextFieldValidationRule {
    /// Каждый раз при изменении текста
    case onChange
    /// При завершении редактирования
    case onEndEditing
    /// Никогда
    ///
    /// Полезно использовать, если триггером валидации является внешнее событие.
    /// Например, нажатие на кнопку
    case never
}

//
//  File.swift
//  
//
//  Created by viktor.volkov on 25.03.2023.
//

import Foundation

/// Описывает валидацию ввода
public struct ELTextFieldValidation {
    /// Предоставляет правило валидации
    public let validator: ELTextFieldValidator
    /// Предоставляет правило срабатывания проверки валидности текста
    public let rule: ELTextFieldValidationRule
    
    /// - Parameters:
    ///   - validator: Валидатор
    ///   - rule: Правило срабатывания валидации
    public init(validator: ELTextFieldValidator,
                rule: ELTextFieldValidationRule) {
        self.validator = validator
        self.rule = rule
    }
    
    /// Создает Валидацию с `rule = .never`
    ///
    /// - Parameter validator: Валидатор
    public init(validator: ELTextFieldValidator) {
        self.init(validator: validator, rule: .never)
    }
    
    /// Дефолтная Валидация
    ///
    /// Создает Валидацию с `validator = ELDefaultTextFieldValidator` и `rule = .never`
    public static let `default` = ELTextFieldValidation.init(validator: ELDefaultTextFieldValidator())
}

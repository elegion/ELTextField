//
//  File.swift
//  
//
//  Created by viktor.volkov on 25.03.2023.
//

import Foundation

/// Правило срабатывания валидации поля ввода
public enum ELTextFieldValidationRule {
    /// Каждый раз при изменении текста
    case onChange
    /// При завершении редактирования
    case onEndEditing
    /// Никогда
    case never
}

public struct ELTextFieldValidation {
    public let validator: ELTextFieldValidator
    public let rule: ELTextFieldValidationRule
    
    public init(validator: ELTextFieldValidator,
                rule: ELTextFieldValidationRule) {
        self.validator = validator
        self.rule = rule
    }
    
    public init(validator: ELTextFieldValidator) {
        self.init(validator: validator, rule: .never)
    }
    
    public static let `default` = ELTextFieldValidation.init(validator: ELDefaultTextFieldValidator())
}

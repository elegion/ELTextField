//
// Created by viktor.volkov on 18.01.2022.
// Copyright © 2022 'E-Legion' Ltd. All rights reserved.
//

import Foundation

/// Валидатор для проверки корректности введенного текста
public protocol ELTextFieldValidator {
    func isValid(text: String?) -> Bool
}

public enum ELTextFieldValidationRule {
    case onChange
    case onEndEditing
    case none
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
        self.init(validator: validator, rule: .none)
    }
    
    public static let `default` = ELTextFieldValidation.init(validator: ELDefaultTextFieldValidator())
}

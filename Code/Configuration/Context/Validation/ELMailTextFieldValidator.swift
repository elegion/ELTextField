//
//  ELMailTextFieldValidator.swift
//
//
//  Created by viktor.volkov on 25.03.2023.
//

import Foundation

/// Валидатор поля e-mail
public class ELMailTextFieldValidator: ELTextFieldValidator {
    
    private enum Constants {
        static let matchRule = "SELF MATCHES %@"
        static let mailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    }

    public func isValid(text: String?) -> Bool {
        let predicate = NSPredicate(format: Constants.matchRule, Constants.mailRegex)
        return predicate.evaluate(with: text ?? "")
    }

    public init() {}
}

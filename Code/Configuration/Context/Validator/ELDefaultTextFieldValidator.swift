//
//  ELDefaultTextFieldValidator.swift
//  
//
//  Created by viktor.volkov on 25.03.2023.
//

import Foundation

public class ELDefaultTextFieldValidator: ELTextFieldValidator {
    
    public func isValid(text: String?) -> Bool {
        text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false
    }

    public init() {}
}

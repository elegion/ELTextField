//
//  File.swift
//  
//
//  Created by viktor.volkov on 21.04.2023.
//

import Foundation

public final class ELNotEmptyTextFieldValidator: ELTextFieldValidator {
    
    public func isValid(text: String?) -> Bool {
        guard let text else {
            return false
        }
        return !text.isEmpty
    }
    
    public init() {}
}

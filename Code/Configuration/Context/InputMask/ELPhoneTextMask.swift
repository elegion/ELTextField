//
//  File.swift
//  
//
//  Created by viktor.volkov on 25.03.2023.
//

import Foundation

public struct ELPhoneTextMask: ELTextFieldInputMask {
    
    let phoneCode: String
    let inputMask: String
    let outputMask: String
    
    public func maskedText(from rawText: String?) -> String {
        (rawText ?? "")
            .components(separatedBy: .decimalDigits.inverted)
            .joined()
            .applyPhonePatternOnNumbers(phoneCode: phoneCode,
                                        pattern: inputMask,
                                        phoneCodeCharacter: "$",
                                        replacementCharacter: "#")
    }
    
    public func rawText(from maskedText: String?) -> String {
        removePhoneCode(phoneCode, from: maskedText ?? "")
            .components(separatedBy: .decimalDigits.inverted)
            .joined()
            .applyPhonePatternOnNumbers(phoneCode: phoneCode,
                                        pattern: outputMask,
                                        phoneCodeCharacter: "$",
                                        replacementCharacter: "#")
    }
    
    public func deleteLastItemLogic(inputText: String) -> String {
        ""
    }
    
    public init(phoneCode: String,
                inputMask: String,
                outputMask: String) {
        self.phoneCode = phoneCode
        self.inputMask = inputMask
        self.outputMask = outputMask
    }
    
    private func removePhoneCode(_ code: String, from text: String) -> String {
        text.replacingOccurrences(of: code, with: "")
    }
}

private extension String {
    
    func applyPhonePatternOnNumbers(phoneCode: String,
                                    pattern: String,
                                    phoneCodeCharacter: Character,
                                    replacementCharacter: Character,
                                    applyOnEmpty: Bool = false) -> String {
        var digits = self
        
        if digits.isEmpty, applyOnEmpty, let firstDigitIndex = pattern.firstIndex(of: replacementCharacter) {
            return String(pattern.prefix(upTo: firstDigitIndex))
        }
        
        let patternCopy = pattern.replacingOccurrences(of: String(phoneCodeCharacter), with: phoneCode)
        
        for index in patternCopy.indices where index < digits.endIndex {
            let character = patternCopy[index]
            
            if character != replacementCharacter {
                digits.insert(character, at: index)
            }
        }
        
        return String(digits.prefix(patternCopy.count))
    }
}

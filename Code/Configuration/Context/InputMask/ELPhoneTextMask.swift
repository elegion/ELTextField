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
    let applyCodeOnEmpty: Bool

    public func maskedText(from rawText: String?) -> String {
        convert(text: rawText, using: inputMask)
    }

    public func rawText(from maskedText: String?) -> String {
        convert(text: maskedText, using: outputMask)
    }

    public func deleteLastItem(inputText: String) -> String {
        String(maskedText(from: inputText).dropLast())
    }

    public init(
        phoneCode: String,
        inputMask: String,
        outputMask: String,
        applyCodeOnEmpty: Bool = false
    ) {
        self.phoneCode = phoneCode
        self.inputMask = inputMask
        self.outputMask = outputMask
        self.applyCodeOnEmpty = applyCodeOnEmpty
    }

    private func convert(text: String?, using mask: String) -> String {
        removePhoneCode(phoneCode, from: text ?? "")
            .components(separatedBy: .decimalDigits.inverted)
            .joined()
            .applyPhonePatternOnNumbers(
                phoneCode: phoneCode,
                pattern: mask,
                phoneCodeCharacter: "$",
                replacementCharacter: "#",
                applyOnEmpty: applyCodeOnEmpty
            )
    }

    private func removePhoneCode(_ code: String, from text: String) -> String {
        text.replacingOccurrences(of: code, with: "")
    }
}

extension String {

    func applyPhonePatternOnNumbers(
        phoneCode: String,
        pattern: String,
        phoneCodeCharacter: Character,
        replacementCharacter: Character,
        applyOnEmpty: Bool = false
    ) -> String {
        var digits = self

        let patternCopy = pattern.replacingOccurrences(of: String(phoneCodeCharacter), with: phoneCode)

        if digits.isEmpty, applyOnEmpty, let firstDigitIndex = patternCopy.firstIndex(of: replacementCharacter) {
            return String(patternCopy.prefix(upTo: firstDigitIndex))
        }

        for index in patternCopy.indices where index < digits.endIndex {
            let character = patternCopy[index]

            if character != replacementCharacter {
                digits.insert(character, at: index)
            }
        }

        return String(digits.prefix(patternCopy.count))
    }
    
    func applyPatternOnNumbers(pattern: String,
                               replacementCharacter: Character,
                               applyOnEmpty: Bool = false) -> String {
        var digits = components(separatedBy: CharacterSet.decimalDigits.inverted).joined()

        if digits.isEmpty, applyOnEmpty, let firstDigitIndex = pattern.firstIndex(of: replacementCharacter) {
            return String(pattern.prefix(upTo: firstDigitIndex))
        }
        
        for index in pattern.indices where index < digits.endIndex {
            let character = pattern[index]
            
            if character != replacementCharacter {
                digits.insert(character, at: index)
            }
        }
        
        return String(digits.prefix(pattern.count))
    }
}

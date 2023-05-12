//
//  File.swift
//  
//
//  Created by viktor.volkov on 12.05.2023.
//

import Foundation

/// Маска цифрового ввода
public struct ELDigitTextMask: ELTextFieldInputMask {
    
    private enum Constants {
        static let sharpSymbol = Character("#")
    }
    
    private let mask: String
    
    /// Создает маску для ввода цифр
    ///
    /// - Parameter mask: Маска, по которой будет осуществлено форматирование
    ///
    /// Для задания маски необходимо вводить маску с использованием символов `#`:
    ///
    ///     let mask = ELDigitMask(mask: "# ### ### ##-##")
    ///     let maskedText = mask.maskedText(from: "12345678901")
    ///     print(maskedText)
    ///     // Prints "1 234 567 89-01"
    ///
    public init(mask: String) {
        self.mask = mask
    }
    
    public func maskedText(from rawText: String?) -> String {
        rawText?.applyPatternOnNumbers(pattern: mask, replacementCharacter: Constants.sharpSymbol) ?? ""
    }
    
    public func rawText(from maskedText: String?) -> String {
        maskedText?.components(separatedBy: CharacterSet.decimalDigits.inverted).joined() ?? ""
    }
    
    public func deleteLastItem(inputText: String) -> String {
        String(maskedText(from: inputText).dropLast())
    }
}

//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation

/// Маска, которая не изменяет введенный текст
public struct ELDefaultTextMask: ELTextFieldInputMask {
    
    public func maskedText(from rawText: String?) -> String {
        rawText ?? ""
    }

    public func rawText(from maskedText: String?) -> String {
        maskedText ?? ""
    }

    public func deleteLastItem(inputText: String) -> String {
        String(maskedText(from: inputText).dropLast())
    }

    public init() {}
}

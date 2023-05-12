//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation

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


public struct ELDigitTextMask: ELTextFieldInputMask {
    
    private let mask: String
    
    public init(mask: String) {
        self.mask = mask
    }
    
    public func maskedText(from rawText: String?) -> String {
        rawText?.applyPatternOnNumbers(pattern: mask, replacementCharacter: "#") ?? ""
    }
    
    public func rawText(from maskedText: String?) -> String {
        maskedText?.components(separatedBy: CharacterSet.decimalDigits.inverted).joined() ?? ""
    }
    
    public func deleteLastItem(inputText: String) -> String {
        String(maskedText(from: inputText).dropLast())
    }
}

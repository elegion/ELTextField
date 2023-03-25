//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation

public struct DefaultTextMask: TextFieldInputMask {
    public func maskedText(from rawText: String?) -> String {
        rawText ?? ""
    }

    public func rawText(from maskedText: String?) -> String {
        maskedText ?? ""
    }

    public func deleteLastItemLogic(inputText: String) -> String {
        String(maskedText(from: inputText).dropLast())
    }

    public init() {}
}

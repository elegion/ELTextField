//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation
import UIKit

/// Содержит все поля, необходимые для настройки ввода
public protocol ELTextFieldInputTraits {
    var isSecureTextEntry: Bool { get set }
    var keyboardType: UIKeyboardType { get set }
    var contentType: UITextContentType? { get set }
    var returnKeyType: UIReturnKeyType { get set }
    var autocorrectionType: UITextAutocorrectionType { get set }
    var spellCheckingType: UITextSpellCheckingType { get set }
    var autocapitalizationType: UITextAutocapitalizationType { get set }
}

public struct ELDefaultTextFieldInputTraits: ELTextFieldInputTraits {
    public var isSecureTextEntry = false
    public var keyboardType: UIKeyboardType = .default
    public var contentType: UITextContentType?
    public var returnKeyType: UIReturnKeyType = .done
    public var autocorrectionType: UITextAutocorrectionType = .no
    public var spellCheckingType: UITextSpellCheckingType = .no
    public var autocapitalizationType: UITextAutocapitalizationType = .none

    public init(isSecureTextEntry: Bool = false,
                keyboardType: UIKeyboardType = .default,
                contentType: UITextContentType? = nil,
                returnKeyType: UIReturnKeyType = .done,
                autocorrectionType: UITextAutocorrectionType = .no,
                spellCheckingType: UITextSpellCheckingType = .no,
                autocapitalizationType: UITextAutocapitalizationType = .none) {
        self.isSecureTextEntry = isSecureTextEntry
        self.keyboardType = keyboardType
        self.contentType = contentType
        self.returnKeyType = returnKeyType
        self.autocorrectionType = autocorrectionType
        self.spellCheckingType = spellCheckingType
        self.autocapitalizationType = autocapitalizationType
    }
}

//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation
import UIKit

public protocol ELTextFieldInputTraits {
    var isSecureTextEntry: Bool { get set }
    var keyboardType: UIKeyboardType { get set }
    var contentType: UITextContentType? { get set }
    var returnKeyType: UIReturnKeyType { get set }
    var autocorrectionType: UITextAutocorrectionType { get set }
    var spellCheckingType: UITextSpellCheckingType { get set }
    var autocapitalizationType: UITextAutocapitalizationType { get set }
}

public struct DefaultTextFieldInputTraits: ELTextFieldInputTraits {
    public var isSecureTextEntry: Bool = false
    public var keyboardType: UIKeyboardType = .default
    public var contentType: UITextContentType?
    public var returnKeyType: UIReturnKeyType = .done
    public var autocorrectionType: UITextAutocorrectionType = .no
    public var spellCheckingType: UITextSpellCheckingType = .no
    public var autocapitalizationType: UITextAutocapitalizationType = .none

    public init() {}
}

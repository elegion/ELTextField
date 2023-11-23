//
//  File.swift
//
//
//  Created by viktor.volkov on 25.03.2023.
//

import Foundation
import UIKit

extension ELTextView: ELTextInput {
    var enteredText: String? {
        get { text }
        set {
            if attributedTextMapper != nil {
                attributedText = attributedTextMapper?(newValue)
            } else {
                text = newValue
            }
            if let val = newValue {
                placeholderHidden = !val.isEmpty
            }
        }
    }
    
    var isSecureText: Bool {
        get { isSecureTextEntry }
        set { isSecureTextEntry = newValue }
    }
    
    var input: UIView? {
        get { inputView }
        set { inputView = newValue }
    }

    var accesory: UIView? {
        get { inputAccessoryView }
        set { inputAccessoryView = newValue }
    }

    var leftImageView: UIView? {
        get { nil }
        set { }
    }
    var rightImageView: UIView? {
        get { nil }
        set {}
    }
}

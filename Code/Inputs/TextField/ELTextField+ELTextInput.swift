//
//  ELTextField+ELTextInput.swift
//
//  Created by viktor.volkov on 25.03.2023.
//

import Foundation
import UIKit

extension ELTextField: ELTextInput {
    
    var enteredText: String? {
        get { text }
        set {
            if attributedTextMapper != nil {
                attributedText = attributedTextMapper?(newValue)
            } else {
                text = newValue
            }
        }
    }

    var input: UIView? {
        get { inputView }
        set { inputView = newValue }
    }

    var accesory: UIView? {
        get { inputAccessoryView }
        set { inputAccessoryView = newValue }
    }

    var rightImageView: UIView? {
        get { rightView }
        set { rightView = newValue }
    }
}

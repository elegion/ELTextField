//
//  PNFloatPlaceholderTextFieldBehavior.swift
//  ELTextFieldDemo
//
//  Created by viktor.volkov on 25.03.2023.
//  Copyright © 2023 E-legion. All rights reserved.
//

import ELTextField
import Foundation
import UIKit

class PNFloatPlaceholderTextFieldBehavior: ELDefaultTextFieldBehavior {
    enum AnyValueGender {
        case male
        case female
        case it
        case many
        case notMatter
        
        var text: String {
            "Любое"
        }
    }
    
    let floatingPlaceholder: String?
    let anyValueGender: AnyValueGender
    
    init(
        text: String? = nil,
        textMapper: ((String?) -> NSAttributedString?)? = nil,
        placeholder: String? = nil,
        anyValueGender: AnyValueGender,
        placeholderMapper _: ((String?) -> NSAttributedString?)? = nil,
        rightButtonItem _: ELRightItem? = nil,
        mask: ELTextFieldInputMask = ELDefaultTextMask(),
        traits: ELTextFieldInputTraits = ELDefaultTextFieldInputTraits(),
        validation: ELTextFieldValidation = .init(validator: ELMailTextFieldValidator(), rule: .onChange)
    ) {
        self.floatingPlaceholder = placeholder
        self.anyValueGender = anyValueGender
        let formattedText = mask.maskedText(from: text)
        super.init(
            text: formattedText,
            textMapper: textMapper,
            placeholder: nil,
            placeholderMapper: nil,
            rightItem: nil,
            mask: mask,
            traits: traits,
            validation: validation
        )
    }
    
    override public func updateText(_ newText: String?) {
        super.updateText(newText)
        
        //        updateSelectedValueText?(newText)
    }
}

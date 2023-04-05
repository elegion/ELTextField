//
//  TLTextFieldBehavior.swift
//  ELTextFieldDemo
//
//  Created by viktor.volkov on 05.04.2023.
//  Copyright © 2023 E-legion. All rights reserved.
//

import Foundation
import ELTextField

class TLTextFieldBehavior: ELDefaultTextFieldBehavior {
    
    let floatingPlaceholder: String?
    
    override init(text: String? = nil,
                  textMapper: ((String?) -> NSAttributedString?)? = nil,
                  placeholder: String? = nil,
                  placeholderMapper: ((String?) -> NSAttributedString?)? = nil,
                  rightItem: ELRightItem? = nil,
                  mask: ELTextFieldInputMask = ELDefaultTextMask(),
                  traits: ELTextFieldInputTraits = ELDefaultTextFieldInputTraits(),
                  validation: ELTextFieldValidation = .default) {
        let mapper: (String?) -> NSAttributedString? = {
            $0?.attribute.with(font: .systemFont(ofSize: 15, weight: .regular)).with(foregroundColor: R.color.black1F22229()).build()
        }
        self.floatingPlaceholder = placeholder
        super.init(
            text: text,
            textMapper: mapper,
            placeholder: nil,
            placeholderMapper: nil,
            rightItem: rightItem,
            mask: mask,
            traits: traits,
            validation: validation
        )
    }
}

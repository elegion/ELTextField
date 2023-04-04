//
//  TLTextFieldContainer.swift
//  ELTextFieldDemo
//
//  Created by viktor.volkov on 02.04.2023.
//  Copyright © 2023 E-legion. All rights reserved.
//

import Foundation
import ELTextField
import UIKit
import Swissors

final class TLTextFieldContainer: ELDefaultTextFieldGenericContainer<TLTextFieldConfiguration> {
    
}

extension TLTextFieldContainer: Configurable {
    
    func set(model: ELDefaultTextFieldBehavior) {
        self.setBehavior(model)
    }
}


final class MailBehavior: ELDefaultTextFieldBehavior {
    
    init(mail: String = "") {
        let mapper: (String?) -> NSAttributedString? = {
            $0?.attribute.with(font: .systemFont(ofSize: 15, weight: .bold)).build()
        }
        let rightImage = ELRightItem.image(image: UIImage(systemName: "checkmark"), mode: .always)
        super.init(text: mail,
                   textMapper: mapper,
                   placeholder: "Почта",
                   placeholderMapper: mapper,
                   rightItem: rightImage,
                   mask: ELPhoneTextMask(phoneCode: "+7",
                                         inputMask: "$ (###) ### ## ##",
                                         outputMask: "$##########"),
                   validation: .init(validator: ELMailTextFieldValidator(),
                                     rule: .onEndEditing))
    }
}

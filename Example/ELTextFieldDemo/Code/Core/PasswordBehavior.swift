//
//  PasswordBehavior.swift
//  ELTextFieldDemo
//
//  Created by viktor.volkov on 26.03.2023.
//  Copyright © 2023 E-legion. All rights reserved.
//

import Foundation
import ELTextField
import UIKit

class PasswordBehavior: ELDefaultTextFieldBehavior {
    
    init() {
        var traits = ELDefaultTextFieldInputTraits()
        traits.isSecureTextEntry = true
        super.init(placeholder: "Пароль",
                   rightItem: .secure(image: UIImage(systemName: "eye.fill"), mode: .always),
                   traits: traits)
    }
}

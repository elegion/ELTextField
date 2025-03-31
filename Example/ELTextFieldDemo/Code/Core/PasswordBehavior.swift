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
        super.init(
            placeholder: "Пароль",
            rightMode: ELSecureTextRightViewMode(
                showTextImage: UIImage(systemName: "eye.fill"),
                hideTextImage: UIImage(systemName: "eye.slash.fill")
            )
        )
    }
}

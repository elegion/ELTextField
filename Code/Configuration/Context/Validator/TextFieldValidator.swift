//
// Created by viktor.volkov on 18.01.2022.
// Copyright © 2022 'E-Legion' Ltd. All rights reserved.
//

import Foundation

public protocol TextFieldValidator {
    func isValid(text: String?) -> Bool
}

public class DefaultTextFieldValidator: TextFieldValidator {
    public func isValid(text: String?) -> Bool {
        text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false
    }

    public init() {}
}

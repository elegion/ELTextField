//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation
import UIKit

/// Описывает тип поля ввода
public enum ELTextInputType {
    /// Однострочный ввод
    case singleline
    /// Многострочный ввод
    case multiline

    var isSingleline: Bool {
        self == .singleline
    }
}

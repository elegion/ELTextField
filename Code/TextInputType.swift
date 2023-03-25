//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation
import UIKit

public enum TextInputType {
    case singleline
    case multiline

    var isSingleline: Bool {
        self == .singleline
    }
}

//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation
import UIKit

public struct ELTextInputViewModel {
    public var text: String?
    public var placeholder: String?
    public var rightItem: ELRightItem?
    public var state: ELTextFieldState

    public var attributedPlaceholderMapper: ((String?) -> NSAttributedString?)?
    public var attributedTextMapper: ((String?) -> NSAttributedString?)?
}

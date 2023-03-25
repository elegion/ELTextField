//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation
import UIKit

public struct TextInputViewModel {
    public var text: String?
    public var placeholder: String?
    public var rightButtonItem: RightItem?
    public var showClearButton: Bool
    public var state: TextFieldState

    public var attributedPlaceholderMapper: ((String?) -> NSAttributedString?)?
    public var attributedTextMapper: ((String?) -> NSAttributedString?)?
}

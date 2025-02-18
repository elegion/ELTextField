//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation
import UIKit

public protocol ELTextInput: UIView {
    var attributedTextMapper: ((String?) -> NSAttributedString?)? { get set }
    var enteredText: String? { get set }
    var isSecureText: Bool { get set }
    var inputView: UIView? { get set }
    var inputAccessoryView: UIView? { get set }
    var leftView: UIView? { get set }
    var rightView: UIView? { get set }
}

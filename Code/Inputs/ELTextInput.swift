//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation
import UIKit

public protocol ELTextInput: UIView {
    var attributedTextMapper: ((String?) -> NSAttributedString?)? { get set }
    var enteredText: String? { get set }
    var input: UIView? { get set }
    var accesory: UIView? { get set }
    var rightImageView: UIView? { get set }
}

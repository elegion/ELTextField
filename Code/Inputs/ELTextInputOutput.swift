//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation
import UIKit

/// Протокол, в котором описаны методы делегата TextInput'a
public protocol ELTextInputOutput: AnyObject {
    func textInputShouldClear(_ textInput: ELTextInput) -> Bool
    func textInputShouldBeginEditing(_ textInput: ELTextInput) -> Bool
    func textInputdDidEndEditing(_ textInput: ELTextInput)
    func textInput(_ textInput: ELTextInput & UITextInput,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    func textInputShouldReturn(_ textInput: ELTextInput) -> Bool
    func textInput(_ textInput: ELTextInput,
                   canPerformAction action: Selector,
                   withSender sender: Any?) -> Bool
}

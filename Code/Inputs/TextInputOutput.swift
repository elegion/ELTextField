//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation
import UIKit

/// Протокол, в котором описаны методы делегата TextInput'a
public protocol TextInputOutput: AnyObject {
    func textInputShouldClear(_ textInput: TextInput) -> Bool
    func textInputShouldBeginEditing(_ textInput: TextInput) -> Bool
    func textInputdDidEndEditing(_ textInput: TextInput)
    func textInput(_ textInput: TextInput & UITextInput,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    func textInputShouldReturn(_ textInput: TextInput) -> Bool
    func textInput(_ textInput: TextInput,
                   canPerformAction action: Selector,
                   withSender sender: Any?) -> Bool
}

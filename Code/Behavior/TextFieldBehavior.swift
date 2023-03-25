//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation

public protocol TextFieldBehavior: TextInputOutput {
    var mask: TextFieldInputMask { get }
    var traits: TextFieldInputTraits { get }
    var validator: TextFieldValidator { get }
    var viewModel: TextInputViewModel { get }

    var isValid: Bool { get }

    var onChanged: ((String) -> Void)? { get set }
    var onEndEditing: (() -> Void)? { get set }

    func configure(textInput: TextInput & TextInputConfigurable)
    func updateState(_ state: TextFieldState)
    func updateText(_ newText: String?)
}

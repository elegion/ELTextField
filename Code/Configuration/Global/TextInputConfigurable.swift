//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation
import UIKit

public enum TextFieldBehaviorAction {
    case startEditing
    case endEditing
}

/// Протокол, который позволяет конфигурировать представление TextInput
public protocol TextInputConfigurable {
    var outputDelegate: TextInputOutput? { get set }
    var behaviorAction: ((TextFieldBehaviorAction) -> Void)? { get set }

    func configureLayer(_ configuration: TextInputLayerConfiguration)
    func configureTraits(_ traits: TextFieldInputTraits)
    func configureViewModel(_ viewModel: TextInputViewModel)
    func updateState(_ textFieldState: TextFieldState)
}

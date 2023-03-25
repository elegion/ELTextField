//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation
import UIKit

/// Протокол, который позволяет конфигурировать представление TextInput
public protocol ELTextInputConfigurable: AnyObject {
    var textInputDelegate: ELTextInputDelegate? { get set }

    func configureLayer(_ configuration: ELTextInputLayerConfiguration)
    func configureTraits(_ traits: ELTextFieldInputTraits)
    func configureViewModel(_ viewModel: ELTextInputViewModel)
    func updateState(_ textFieldState: ELTextFieldState)
}

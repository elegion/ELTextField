//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation
import UIKit

/// Конфигурация представления TextInput
public protocol ELTextInputConfigurable: AnyObject {
    var textInputDelegate: ELTextInputDelegate? { get set }
    var touchesDelegate: ELTouchesDelegate? { get set }
    
    /// Настраивает Layer для TextInput
    ///
    /// - Parameter configuration: Все возможные состояния TextInput
    func configureLayer(_ configuration: ELTextInputLayerConfiguration)
    func configureFont(_ configuration: ELTextInputFontConfiguration?)
    
    /// Настраивает Traits для TextInput
    /// - Parameter traits: Traits
    func configureTraits(_ traits: ELTextFieldInputTraits)
    func configureViewModel(_ viewModel: ELTextInputViewModel)
    func updateState(_ textFieldState: ELTextFieldState)
    
    func configureRightItem(with container: ELRightViewContainer?)
    func configureLeftItem(with container: ELLeftViewContainer?)
}

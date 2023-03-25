//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation

/// Протокол для представления Контейнера инпута
public protocol TextFieldConfigurationProtocol {
    static func layer() -> TextInputLayerConfiguration
    static func layer(for state: TextFieldState) -> TextInputLayerConfiguration
    static func rect() -> TextInputRectConfiguration
}

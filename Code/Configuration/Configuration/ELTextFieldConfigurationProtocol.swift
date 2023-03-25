//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation

/// Протокол для представления конфигурации Контейнера инпута
public protocol ELTextFieldConfigurationProtocol {
    /// Layer для состояний
    static func layer(for state: ELTextFieldState) -> ELTextInputLayerConfiguration
    /// Возвращает размер контейнера и позиции для поля ввода
    static func rect() -> ELTextInputRectConfiguration
}

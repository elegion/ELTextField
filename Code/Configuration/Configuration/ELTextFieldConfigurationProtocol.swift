//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation

/// Протокол для представления конфигурации контейнера ввода
public protocol ELTextFieldConfigurationProtocol {
    
    /// Возвращает *Layers* для состояний
    ///
    /// Вызывается в момент изменения состояния поля ввода
    ///
    /// - Parameter state: Состояние, для которого нужно вернуть конфигурацию
    /// - Returns: *Layer* для запрашиваемой конфигурации
    static func layer(for state: ELTextFieldState) -> ELTextInputLayerConfiguration
    /// Возвращает размер контейнера и позиции для поля ввода
    static func rect() -> ELTextInputRectConfiguration
}

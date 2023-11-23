//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation

/// Состояние TextField
public enum ELTextFieldState {
    /// Не в фокусе
    case `default`
    /// Ошибка (например, валидации)
    case error
    /// Редактирвание
    case editing
    /// Не доступно для взаимодействия
    case disabled
}

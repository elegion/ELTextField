//
// Created by viktor.volkov on 18.01.2022.
// Copyright © 2022 'E-Legion' Ltd. All rights reserved.
//

import Foundation

/// Валидатор для проверки корректности введенного текста
public protocol ELTextFieldValidator {
    
    /// Проверяет валидность текста
    ///
    /// - Parameter text: Введенный текст
    /// - Returns: Валиден ли текст по объявленным правилам
    func isValid(text: String?) -> Bool
}

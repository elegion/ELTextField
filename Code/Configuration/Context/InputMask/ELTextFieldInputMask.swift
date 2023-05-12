//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation

/// Маска для преобразования введенного текста в пользовательское представление и наоборот
public protocol ELTextFieldInputMask {
    
    /// Возвращает текст для отображения пользователю
    ///
    /// - Parameter rawText: Введенный текст
    /// - Returns: Текст для отображения в поле ввода
    func maskedText(from rawText: String?) -> String
    
    /// Возвращает текст в `сыром` виде
    func rawText(from maskedText: String?) -> String
    
    /// Удаление последнего элемента
    /// - Parameter inputText: Введенный текст
    /// - Returns: Текст для отображения в поле ввода
    func deleteLastItem(inputText: String) -> String
}

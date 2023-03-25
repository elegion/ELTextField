//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation

/// Маска для преобразования введенного текста в пользовательское представление и наоборот
public protocol ELTextFieldInputMask {
    /// Возвращает текст для отображения пользователю
    func maskedText(from rawText: String?) -> String
    /// Возвращает текст в 'сыром' виде
    func rawText(from maskedText: String?) -> String
    /// Логика удаления последнего элемента
    func deleteLastItemLogic(inputText: String) -> String
}

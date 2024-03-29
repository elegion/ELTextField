//
//  RightItem.swift
//
//
//  Created by viktor.volkov on 13.12.2022.
//

import Foundation
import UIKit

/// Перечисление для отображения правого айтема
public enum ELRightItem {
    
    /// Статичное изображение
    case image(image: UIImage?, mode: Mode)
    /// Статичное изображение с возможностью обработки нажатия
    case action(image: UIImage?, mode: Mode, behavior: Behavior)
    /// Кастомная view
    case custom(view: UIView, mode: Mode)
    /// Отображение контента поля ввода пароля
    case secure(showImage: UIImage?, hideImage: UIImage?, mode: Mode)
    /// Системная кнопка очистки поля
    case systemClear
    
    var isSystemClear: Bool {
        switch self {
        case .action,
             .custom,
             .image,
             .secure:
            return false
        case .systemClear:
            return true
        }
    }
}

public extension ELRightItem {
    
    /// Поведение при нажатии на айтем
    enum Behavior {
        /// Удаление текста
        case delete
        /// Кастомное событие
        ///
        /// - Parameter onTap: Замыкание для обработки события
        case custom(onTap: () -> Void)
    }
    
    /// Описание режима отображения правого айтема
    enum Mode {
        /// Режимы отображения, предлагаемые системой
        case system(viewMode: UITextField.ViewMode)
        
        var systemMode: UITextField.ViewMode? {
            switch self {
            case let .system(viewMode):
                return viewMode
            }
        }
    }
}

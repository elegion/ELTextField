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
    /// Поведение при нажатии на айтем
    public enum Behavior {
        case delete
        case custom(onTap: () -> Void)
    }
    /// Статичное изображение
    case image(image: UIImage?, mode: UITextField.ViewMode)
    /// Статичное изображение с возможностью обработки нажатия
    case action(image: UIImage?, mode: UITextField.ViewMode, behavior: Behavior)
    /// Кастомная view
    case custom(view: UIView, mode: UITextField.ViewMode)
    /// Отображение контента поля ввода пароля
    case secure(showImage: UIImage?, hideImage: UIImage?, mode: UITextField.ViewMode)
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

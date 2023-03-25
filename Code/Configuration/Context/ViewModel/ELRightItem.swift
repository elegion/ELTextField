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
    
    case image(image: UIImage?, mode: UITextField.ViewMode)
    case action(image: UIImage?, mode: UITextField.ViewMode, behavior: Behavior)
    case custom(view: UIView, mode: UITextField.ViewMode)
    case systemClear
    
    var isSystemClear: Bool {
        switch self {
        case .image, .action, .custom:
            return false
        case .systemClear:
            return true
        }
    }
}

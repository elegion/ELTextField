//
//  RightItem.swift
//
//
//  Created by viktor.volkov on 13.12.2022.
//

import Foundation
import UIKit

public enum RightItem {
    public enum Behavior {
        case delete
        case custom(onTap: () -> Void)
    }

    case image(image: UIImage?, mode: UITextField.ViewMode)
    case action(image: UIImage?, mode: UITextField.ViewMode, behavior: Behavior)
    case custom(view: UIView, mode: UITextField.ViewMode)
}

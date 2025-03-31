//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation
import UIKit

/// Используется для хранения данных о TextInput
public struct ELTextInputViewModel: Sendable {
    public var text: String?
    public var placeholder: String?
    public var leftView: UIView?
    public var state: ELTextFieldState
    
    /// Маппер для преобразования текста плейсхолдера
    ///
    /// Используется в случае, когда плейсхолдер имеет кастомный шрифт
    public var attributedPlaceholderMapper: (@Sendable (String?) -> NSAttributedString?)?
    
    /// Маппер для преобразования введенного текста
    ///
    /// Используется в случае, когда текст имеет кастомный шрифт
    public var attributedTextMapper: (@Sendable (String?) -> NSAttributedString?)?
}

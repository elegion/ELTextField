//
//  File.swift
//  
//
//  Created by viktor.volkov on 21.09.2023.
//

import Foundation
import UIKit

/// Протокол для создания кастомного поведения правой иконки
public protocol ELRightViewMode: AnyObject {
    
    func initialItem(textInput: ELTextInput) -> ELRightItem?
    func itemForBeginEditing(textInput: ELTextInput) -> ELRightItem?
    func itemForEndEditing(textInput: ELTextInput) -> ELRightItem?
}

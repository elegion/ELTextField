//
//  File.swift
//  
//
//  Created by viktor.volkov on 13.06.2023.
//

import Foundation

/// Методы делегата для обработки дополнительных событий с полем ввода
public protocol ELContainerDelegate: AnyObject {
    
    func startEditing(in behavior: ELTextFieldBehavior)
    func endEditing(in behavior: ELTextFieldBehavior)
    func container(_ behavior: ELTextFieldBehavior,
                   changedText text: String)
    func container(_ behavior: ELTextFieldBehavior,
                   changedState state: ELTextFieldState)
    func `return`(in behavior: ELTextFieldBehavior)
    func becameDisabled(in behavior: ELTextFieldBehavior)
}

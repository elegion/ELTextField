//
//  File.swift
//  
//
//  Created by viktor.volkov on 22.09.2023.
//

import Foundation
import UIKit

/// Содержит информацию о rightView
public struct ELRightViewContainer {
    let view: UIView?
    let rightViewMode: UITextField.ViewMode
    let clearButtonMode: UITextField.ViewMode
    let isSecureTextEntry: Bool
    
    public init(
        view: UIView?,
        rightViewMode: UITextField.ViewMode,
        isSecureTextEntry: Bool
    ) {
        self.view = view
        self.rightViewMode = rightViewMode
        self.clearButtonMode = .never
        self.isSecureTextEntry = isSecureTextEntry
    }
    
    public init(
        clearButtonMode: UITextField.ViewMode
    ) {
        self.view = nil
        self.rightViewMode = .never
        self.clearButtonMode = clearButtonMode
        self.isSecureTextEntry = false
    }
}

//
//  ELRightViewContainer.swift
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
    
    private init(
        view: UIView?,
        rightViewMode: UITextField.ViewMode,
        clearButtonMode: UITextField.ViewMode,
        isSecureTextEntry: Bool
    ) {
        self.view = view
        self.rightViewMode = rightViewMode
        self.clearButtonMode = clearButtonMode
        self.isSecureTextEntry = isSecureTextEntry
    }
    
    public init(
        view: UIView?,
        rightViewMode: UITextField.ViewMode,
        isSecureTextEntry: Bool
    ) {
        self.init(
            view: view,
            rightViewMode: rightViewMode,
            clearButtonMode: .never,
            isSecureTextEntry: isSecureTextEntry
        )
    }
    
    public init(
        clearButtonMode: UITextField.ViewMode
    ) {
        self.init(
            view: nil,
            rightViewMode: .never,
            clearButtonMode: clearButtonMode,
            isSecureTextEntry: false
        )
    }
}

public struct ELLeftViewContainer {
    let view: UIView?
    let leftViewMode: UITextField.ViewMode
    
    init(
        view: UIView?,
        leftViewMode: UITextField.ViewMode
    ) {
        self.view = view
        self.leftViewMode = leftViewMode
    }
}

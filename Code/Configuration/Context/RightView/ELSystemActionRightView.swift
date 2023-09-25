//
//  File.swift
//  
//
//  Created by viktor.volkov on 22.09.2023.
//

import Foundation
import UIKit

public final class ELSystemActionRightView: ELRightViewMode {
    
    private let view: UIView
    private let viewMode: UITextField.ViewMode
    
    public init(image: UIImage?, viewMode: UITextField.ViewMode, behavior: ELRightItem.Behavior) {
        let button = UIButton(type: .system)
        let action = switch behavior {
        case .delete:
            UIAction {
                _ in
#warning("Как-то достучаться до поля ввода")
                print("delete")
            }
        case let.custom(onTap):
            UIAction { _ in onTap() }
        }
        button.addAction(action, for: .touchUpInside)
        button.setImage(image, for: .normal)
        self.view = button
        self.viewMode = viewMode
    }
    
    public func initialContainer(textInput: ELTextInput) -> ELRightViewContainer {
        .init(view: view, rightViewMode: viewMode, isSecureTextEntry: false)
    }
    
    public func textInput(
        _ textInput: ELTextInput?,
        containerForState state: ELTextFieldState
    ) -> ELRightViewContainer {
        .init(view: view, rightViewMode: viewMode, isSecureTextEntry: false)
    }
}

public final class ELSecureTextRightView: ELRightViewMode {
    private let hiddenImage: UIView?
    private let visibleImage: UIView?
    
    public init(hiddenImage: UIImage?, visibleImage: UIImage?) {
        self.hiddenImage = UIImageView(image: hiddenImage)
        self.visibleImage = UIImageView(image: visibleImage)
    }
    
    public func initialContainer(textInput: ELTextInput) -> ELRightViewContainer {
        .init(
            view: textInput.isSecureText ? hiddenImage : visibleImage,
            rightViewMode: .always, 
            isSecureTextEntry: textInput.isSecureText
        )
    }
    
    public func textInput(_ textInput: ELTextInput?, containerForState state: ELTextFieldState) -> ELRightViewContainer {
        .init(
            view: textInput?.isSecureText == true ? hiddenImage : visibleImage,
            rightViewMode: .always,
            isSecureTextEntry: textInput?.isSecureText ?? false
        )
    }
}

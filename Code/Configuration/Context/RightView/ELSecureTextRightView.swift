//
//  ELSecureTextRightView.swift
//
//
//  Created by viktor.volkov on 03.10.2023.
//

import Foundation
import UIKit

open class ELSecureTextRightViewMode: ELRightViewMode {
    private let hideTextImage: UIImage?
    private let showTextImage: UIImage?
    private let toggleButton = UIButton(type: .system)
    private let initiallyHidden: Bool
    
    public init(
        showTextImage: UIImage?,
        hideTextImage: UIImage?,
        tintColor: UIColor? = nil,
        initiallyHidden: Bool = true
    ) {
        self.hideTextImage = hideTextImage
        self.showTextImage = showTextImage
        self.initiallyHidden = initiallyHidden
        toggleButton.setImage(initiallyHidden ? showTextImage : hideTextImage, for: .normal)
        toggleButton.tintColor = tintColor
    }
    
    open func initialContainer(
        textInput: ELTextInput
    ) -> ELRightViewContainer {
        toggleButton.addAction(UIAction {
            [weak self, weak textInput] _ in
            
            textInput?.isSecureText.toggle()
            self?
                .toggleButton
                .setImage(
                    textInput?.isSecureText == true ? self?.showTextImage : self?.hideTextImage,
                    for: .normal
                )
        }, for: .touchUpInside)
        return .init(
            view: toggleButton,
            rightViewMode: .always,
            isSecureTextEntry: initiallyHidden
        )
    }
    
    open func textInput(
        _ textInput: ELTextInput?,
        containerForState state: ELTextFieldState
    ) -> ELRightViewContainer {
        .init(
            view: toggleButton,
            rightViewMode: .always,
            isSecureTextEntry: textInput?.isSecureText ?? false
        )
    }
}

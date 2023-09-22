//
//  File.swift
//  
//
//  Created by viktor.volkov on 22.09.2023.
//

import Foundation
import UIKit

public final class ELSystemImageRightView: ELRightViewMode {
    
    private let view: UIView
    private let viewMode: UITextField.ViewMode
    
    public init(image: UIImage?, viewMode: UITextField.ViewMode) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .center
        self.view = imageView
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

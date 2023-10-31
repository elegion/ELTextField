//
//  ELStaticLeftViewMode.swift
//
//
//  Created by viktor.volkov on 31.10.2023.
//

import Foundation
import UIKit

public class ELStaticLeftViewMode: ELLeftViewMode {
    
    private let container: ELLeftViewContainer
    
    public init(view: UIView?) {
        self.container = ELLeftViewContainer(view: view, leftViewMode: .always)
    }
    
    public convenience init(image: UIImage?, tintColor: UIColor? = nil) {
        let imageView = UIImageView(image: image)
        imageView.tintColor = tintColor
        self.init(view: imageView)
    }
    
    public func initialContainer(textInput: ELTextInput) -> ELLeftViewContainer {
        container
    }
    
    public func textInput(
        _ textInput: ELTextInput?,
        containerForState state: ELTextFieldState
    ) -> ELLeftViewContainer {
        container
    }
}

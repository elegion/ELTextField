//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation
import UIKit

public protocol OutputHandlerProtocol: AnyObject {
    
    func startEditing(in behavior: ELTextFieldBehavior)
    func endEditing(in behavior: ELTextFieldBehavior)
    func container(_ behavior: ELTextFieldBehavior, changedText text: String)
    func `return`(in behavior: ELTextFieldBehavior)
    func becameDisabled(in behavior: ELTextFieldBehavior)
}

open class ELTextFieldGenericContainer<Configuration: ELTextFieldConfigurationProtocol>: UIView, OutputHandlerProtocol {
    
    public typealias C = Configuration
    
    public let textInput: ELTextInput & ELTextInputConfigurable

    public init(type: ELTextInputType = .singleline) {
        self.textInput = type.isSingleline ? ELTextField<Configuration>() : ELTextView<Configuration>()
        super.init(frame: .zero)

        addSubview(textInput)
        textInput.translatesAutoresizingMaskIntoConstraints = false
        textInput.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textInput.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        textInput.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        textInput.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    override public init(frame: CGRect) {
        self.textInput = ELTextField<Configuration>()
        super.init(frame: frame)

        addSubview(textInput)
        textInput.translatesAutoresizingMaskIntoConstraints = false
        textInput.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textInput.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        textInput.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        textInput.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func setBehavior(_ behavior: ELTextFieldBehavior?) {
        behavior?.configure(textInput: textInput)
        behavior?.containerDelegate = self
        textInput.textInputDelegate = behavior
    }

    public func setBehaviorHandler(_ handler: ((ELTextFieldBehaviorAction) -> Void)?) {
        textInput.behaviorAction = handler
    }

    @discardableResult
    override open func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()

        return textInput.becomeFirstResponder()
    }
    
    
    open func startEditing(in behavior: ELTextFieldBehavior) { }
    
    open func endEditing(in behavior: ELTextFieldBehavior) { }
    
    open func container(_ behavior: ELTextFieldBehavior, changedText text: String) { }
    
    open func `return`(in behavior: ELTextFieldBehavior) { }
    
    open func becameDisabled(in behavior: ELTextFieldBehavior) { }
}

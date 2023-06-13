//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation
import UIKit

/// Содержит методы делегата для обработки дополнительных событий с полем ввода
public protocol ELContainerDelegate: AnyObject {

    func startEditing(in behavior: ELTextFieldBehavior)
    func endEditing(in behavior: ELTextFieldBehavior)
    func container(_ behavior: ELTextFieldBehavior, changedText text: String)
    func container(_ behavior: ELTextFieldBehavior, changedState state: ELTextFieldState)
    func `return`(in behavior: ELTextFieldBehavior)
    func becameDisabled(in behavior: ELTextFieldBehavior)
}

public typealias ELDefaultTextFieldGenericContainer<
    C: ELTextFieldConfigurationProtocol
> = ELTextFieldGenericContainer<C, ELDefaultTextFieldBehavior>

open class ELTextFieldGenericContainer<
    Configuration: ELTextFieldConfigurationProtocol,
    Behavior: ELTextFieldBehavior
>: UIView, ELContainerDelegate {

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

    open func setBehavior(_ behavior: Behavior?) {
        behavior?.configure(textInput: textInput)
        behavior?.containerDelegate = self
        textInput.textInputDelegate = behavior
    }

    @discardableResult
    override open func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()

        return textInput.becomeFirstResponder()
    }

    open func startEditing(in behavior: ELTextFieldBehavior) {}

    open func endEditing(in behavior: ELTextFieldBehavior) {}

    open func container(_ behavior: ELTextFieldBehavior, changedText text: String) {}
    
    open func container(_ behavior: ELTextFieldBehavior, changedState state: ELTextFieldState) {}

    open func `return`(in behavior: ELTextFieldBehavior) {}

    open func becameDisabled(in behavior: ELTextFieldBehavior) {}
}

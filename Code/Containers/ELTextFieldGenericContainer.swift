//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation
import UIKit

/// Контейнер для реализации UI-представления поля ввода
open class ELTextFieldGenericContainer<
    Configuration: ELTextFieldConfigurationProtocol,
    Behavior: ELTextFieldBehavior
>: UIView, ELContainerDelegate {

    #warning("Почему public?")
    public let textInput: ELTextInput & ELTextInputConfigurable

    /// Конструктор с передачей типа поля ввода
    ///
    /// - Parameter type: Тип поля ввода. По умолчанию однострочный
    public init(type: ELTextInputType = .singleline) {
        self.textInput = type.isSingleline ? ELTextField<Configuration>() : ELTextView<Configuration>()
        super.init(frame: .zero)
        
        configure()
    }
    
    override public init(frame: CGRect) {
        self.textInput = ELTextField<Configuration>()
        super.init(frame: frame)

        configure()
    }
        
    open func configure() {
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

    /// Метод для настройки поведения
    ///
    /// Необходимо использовать всегда для того, чтобы поле ввода было связано с Поведением. Если не осуществить настройку – поле ввода не получит должную настройку, а поведение не будет связано с Контейнером.
    ///
    /// - Parameter behavior: Поведение, которое необходимо передать для настройки соответствующего поля ввода
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
    
    @discardableResult
    open override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        
        return textInput.resignFirstResponder()
    }

    open func startEditing(in behavior: ELTextFieldBehavior) {}

    open func endEditing(in behavior: ELTextFieldBehavior) {}

    open func container(_ behavior: ELTextFieldBehavior, changedText text: String) {}
    
    open func container(_ behavior: ELTextFieldBehavior, changedState state: ELTextFieldState) {}

    open func `return`(in behavior: ELTextFieldBehavior) {}

    open func becameDisabled(in behavior: ELTextFieldBehavior) {}
}

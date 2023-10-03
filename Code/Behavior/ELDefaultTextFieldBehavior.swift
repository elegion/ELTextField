//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation
import UIKit

/// Описывает поведение поля ввода по умолчанию
open class ELDefaultTextFieldBehavior: NSObject, ELTextFieldBehavior {
    
    public let mask: ELTextFieldInputMask
    public let traits: ELTextFieldInputTraits
    public let validation: ELTextFieldValidation
    
    public var viewModel: ELTextInputViewModel
    
    public var placeholder: String? {
        viewModel.placeholder
    }
    
    public var value: String {
        viewModel.text ?? ""
    }
    
    open var isValid: Bool {
        validation.validator.isValid(text: viewModel.text)
    }
    
    private let isEditable: Bool
    private var customRightMode: ELRightViewMode?
    
    public var onAction: ((ELBehaviorAction) -> Void)?
    public weak var containerDelegate: ELContainerDelegate?
    var textInput: (ELTextInput & ELTextInputConfigurable)?
    
    /// Создает Поведение
    ///
    /// - Parameters:
    ///   - text: Введенный текст
    ///   - textMapper: Маппер для текста. Необходим в случае, если введенный текст имеет отличный от системного шрифт
    ///   - placeholder: Текст плейсхолдера
    ///   - placeholderMapper: Маппер для плейсхолдера. Необходим в случае, если текст плейсхолдера имеет отличный от системного шрифт
    ///   - isEditable: Флаг, указывающий на возможность редактирования текста
    ///   - rightItem: Правый айтем
    ///   - mask: Маска ввода
    ///   - traits: Настройки клавиатуры
    ///   - validation: Правило валидации поля
    public init(
        text: String? = nil,
        textMapper: ((String?) -> NSAttributedString?)? = nil,
        placeholder: String? = nil,
        placeholderMapper: ((String?) -> NSAttributedString?)? = nil,
        isEditable: Bool = true,
        rightItem: ELRightItem? = nil,
        rightMode: ELRightViewMode? = nil,
        mask: ELTextFieldInputMask = ELDefaultTextMask(),
        traits: ELTextFieldInputTraits = ELDefaultTextFieldInputTraits(),
        validation: ELTextFieldValidation = .default
    ) {
        self.isEditable = isEditable
        self.mask = mask
        self.traits = traits
        self.validation = validation
        customRightMode = rightMode
        self.viewModel = ELTextInputViewModel(
            text: text,
            placeholder: placeholder,
            state: .default,
            attributedPlaceholderMapper: placeholderMapper,
            attributedTextMapper: textMapper
        )
    }

    open func configure(textInput: ELTextInput & ELTextInputConfigurable) {
        self.textInput = textInput
        textInput.input = nil
        textInput.accesory = nil
        textInput.configureTraits(traits)
        textInput.configureViewModel(viewModel)
        textInput.configureRightItem(with: customRightMode?.initialContainer(textInput: textInput))
    }

    public func updateState(_ state: ELTextFieldState) {
        viewModel.state = state
        textInput?.configureRightItem(
            with: customRightMode?.textInput(
                textInput,
                containerForState: state
            )
        )
        textInput?.updateState(viewModel.state)
        containerDelegate?.container(self, changedState: state)
    }

    open func updateText(_ newText: String?) {
        updateText(newValue: newText)
    }

    public func textInputShouldClear(_: ELTextInput) -> Bool {
        updateText("")
        return true
    }

    open func textInputShouldBeginEditing(_: ELTextInput) -> Bool {
        guard isEditable else {
            return false
        }
        switch viewModel.state {
        case .disabled:
            onAction?(.tapOnDisabled)
            containerDelegate?.becameDisabled(in: self)
            return false
        default:
            updateState(.editing)
            return true
        }
    }

    public func textInputDidBeginEditing(_ textInput: ELTextInput) {
        containerDelegate?.startEditing(in: self)
    }
    
    open func textInputdDidEndEditing(_: ELTextInput) {
        onAction?(.endEditing)
        containerDelegate?.endEditing(in: self)
        let stateChanged = triggerValidation(for: .onEndEditing, isEditing: false)
        if !stateChanged {
            updateState(.default)
        }
    }

    /// При вводе текста свайпом происходит рекурсивный вызов методов:
    /// https://stackoverflow.com/questions/58560843/ios-13-crash-with-swipekeyboard-and-textfieldshouldchangecharactersin
    private var lastEntry: String?

    public func textInput(
        _ textInput: ELTextInput & UITextInput,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        var shouldReturn = string.isEmpty && textInput.enteredText.isNilOrEmpty && range.location == .zero && range.length == .zero
        if string.count > 1 {
            if string == lastEntry {
                // Ввод свайпом
                lastEntry = nil
                return false
            } else {
                // Вставка текста
                shouldReturn = false
            }
        }
        lastEntry = string
        if let text = textInput.enteredText, let swiftRange = Range(range, in: text), !shouldReturn {
            let isTextEmpty = textInput.enteredText?.isEmpty ?? true
            let newText: String
            if (range.location + range.length) == text.count, range.length == 1 {
                newText = mask.deleteLastItem(inputText: text)
            } else {
                newText = text.replacingCharacters(in: swiftRange, with: string)
            }
            let newValue = mask.maskedText(from: newText)
            updateText(newValue: newValue)
            _ = triggerValidation(for: .onChange, isEditing: true)
            if !isTextEmpty {
                textInput.setCursorPosition(
                    newTextLength: newText.count,
                    newValueLength: newValue.count,
                    addedTextLength: string.count,
                    range: range
                )
            }
            shouldReturn = false
        }
        if viewModel.state != .error {
            updateState(.editing)
        }
        return shouldReturn
    }

    private func updateText(newValue: String?) {
        textInput?.enteredText = newValue
        viewModel.text = newValue.isNilOrEmpty ? nil : newValue
        onAction?(.changed(newValue: viewModel.text ?? ""))
        updateState(viewModel.state)
        containerDelegate?.container(self, changedText: viewModel.text ?? "")
    }
    
    private func triggerValidation(for rule: ELTextFieldValidationRule, isEditing: Bool) -> Bool {
        guard validation.rule == rule else {
            return false
        }
        if isValid {
            updateState(isEditing ? .editing : .default)
        } else {
            updateState(.error)
        }
        return true
    }

    public func textInputShouldReturn(_ textInput: ELTextInput) -> Bool {
        onAction?(.return)
        containerDelegate?.return(in: self)
        textInput.resignFirstResponder()
        return true
    }

    open func textInput(_: ELTextInput, canPerformAction _: Selector, withSender _: Any?) -> Bool {
        true
    }
    
    open func touchesBegan(in textInput: ELTextInput, touches: Set<UITouch>, with event: UIEvent?) { }
    open func touchesMoved(in textInput: ELTextInput, touches: Set<UITouch>, with event: UIEvent?) { }
    open func touchesEnded(in textInput: ELTextInput, touches: Set<UITouch>, with event: UIEvent?) { }
    open func touchesCancelled(in textInput: ELTextInput, touches: Set<UITouch>, with event: UIEvent?) { }
}

private extension Optional where Wrapped == String {
    
    var isNilOrEmpty: Bool {
        self == nil || self?.isEmpty == true
    }
}

private extension UITextInput {
    func setCursorPosition(
        newTextLength: Int,
        newValueLength: Int,
        addedTextLength: Int,
        range: NSRange
    ) {
        var offset = Int.zero
        if range.length == .zero {
            if range.location + addedTextLength == newTextLength {
                offset = max(newTextLength, newValueLength)
            } else {
                offset = range.location + addedTextLength
            }
        } else {
            if range.location == newTextLength {
                offset = newValueLength
            } else {
                offset = range.location
            }
        }

        guard let textPosition = position(from: beginningOfDocument, offset: offset) else {
            return
        }
        selectedTextRange = textRange(from: textPosition, to: textPosition)
    }
}

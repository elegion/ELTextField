//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation
import UIKit

open class DefaultTextFieldBehavior: NSObject, TextFieldBehavior {
    public var mask: TextFieldInputMask
    public var traits: TextFieldInputTraits
    public var validator: TextFieldValidator
    public var viewModel: TextInputViewModel

    open var isValid: Bool {
        validator.isValid(text: viewModel.text)
    }

    public var onChanged: ((String) -> Void)?
    public var onEndEditing: (() -> Void)?
    public var onReturn: (() -> Void)?
    public var onTapDisabled: (() -> Void)?

    public var textInput: (TextInput & TextInputConfigurable)?

    public init(text: String? = nil,
                textMapper: ((String?) -> NSAttributedString?)? = nil,
                placeholder: String? = nil,
                placeholderMapper: ((String?) -> NSAttributedString?)? = nil,
                rightButtonItem: RightItem? = nil,
                showClearButton: Bool = false,
                mask: TextFieldInputMask = DefaultTextMask(),
                traits: TextFieldInputTraits = DefaultTextFieldInputTraits(),
                validator: TextFieldValidator = DefaultTextFieldValidator()) {
        self.mask = mask
        self.traits = traits
        self.validator = validator
        self.viewModel = TextInputViewModel(text: text,
                                            placeholder: placeholder,
                                            rightButtonItem: rightButtonItem,
                                            showClearButton: showClearButton,
                                            state: .default,
                                            attributedPlaceholderMapper: placeholderMapper,
                                            attributedTextMapper: textMapper)
    }

    open func configure(textInput: TextInput & TextInputConfigurable) {
        self.textInput = textInput
        textInput.input = nil
        textInput.accesory = nil
        textInput.configureTraits(traits)
        textInput.configureViewModel(viewModel)
    }

    public func updateState(_ state: TextFieldState) {
        viewModel.state = state
        textInput?.updateState(viewModel.state)
    }

    open func updateText(_ newText: String?) {
        updateText(newValue: newText)
    }

    public func textInputShouldClear(_: TextInput) -> Bool {
        updateText("")
        return true
    }

    open func textInputShouldBeginEditing(_: TextInput) -> Bool {
        switch viewModel.state {
        case .disabled:
            onTapDisabled?()
            return false
        default:
            updateState(.editing)
            return true
        }
    }

    open func textInputdDidEndEditing(_: TextInput) {
        updateState(.default)
        onEndEditing?()
    }

    /// При вводе текста свайпом происходит рекурсивный вызов методов:
    /// https://stackoverflow.com/questions/58560843/ios-13-crash-with-swipekeyboard-and-textfieldshouldchangecharactersin
    private var lastEntry: String?

    public func textInput(_ textInput: TextInput & UITextInput,
                          shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {
        if viewModel.state != .error {
            updateState(.editing)
        }
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
                newText = mask.deleteLastItemLogic(inputText: text)
            } else {
                newText = text.replacingCharacters(in: swiftRange, with: string)
            }
            let newValue = mask.maskedText(from: newText)
            updateText(newValue: newValue)
            if !isTextEmpty {
                textInput.setCursorPosition(newTextLength: newText.count,
                                            newValueLength: newValue.count,
                                            addedTextLength: string.count,
                                            range: range)
            }
            shouldReturn = false
        }
        return shouldReturn
    }

    private func updateText(newValue: String?) {
        textInput?.enteredText = newValue
        viewModel.text = newValue.isNilOrEmpty == true ? nil : newValue
        onChanged?(viewModel.text ?? "")
    }

    public func textInputShouldReturn(_ textInput: TextInput) -> Bool {
        onReturn?()
        textInput.resignFirstResponder()
        return true
    }

    open func textInput(_: TextInput, canPerformAction _: Selector, withSender _: Any?) -> Bool {
        true
    }
}

private extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        self == nil || self?.isEmpty == true
    }
}

private extension UITextInput {
    func setCursorPosition(newTextLength: Int,
                           newValueLength: Int,
                           addedTextLength: Int,
                           range: NSRange) {
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

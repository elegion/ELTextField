//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation
import UIKit

class ELTextView<Configuration: ELTextFieldConfigurationProtocol>: UITextView, UITextViewDelegate {
    var attributedTextMapper: ((String?) -> NSAttributedString?)?

    private var rectConfiguration: ELTextInputRectConfiguration {
        Configuration.rect()
    }

    private let placeholderLabel = UILabel()

    var placeholder: String? {
        get { placeholderLabel.text }
        set { placeholderLabel.text = newValue }
    }

    var attributedPlaceholder: NSAttributedString? {
        get { placeholderLabel.attributedText }
        set { placeholderLabel.attributedText = newValue }
    }

    public weak var outputDelegate: ELTextInputOutput?
    var behaviorAction: ((ELTextFieldBehaviorAction) -> Void)?

    var placeholderHidden: Bool {
        get { placeholderLabel.isHidden }
        set {
            placeholderLabel.isHidden = newValue
        }
    }

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)

        delegate = self
        addSubview(placeholderLabel)
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        let textInset = rectConfiguration.textInset ?? .zero
        let leadingConstant = textInset.left
        placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                  constant: leadingConstant).isActive = true
        let topConstant = textInset.top
        placeholderLabel.topAnchor.constraint(equalTo: topAnchor,
                                              constant: topConstant).isActive = true
        textContainerInset = UIEdgeInsets(top: topConstant,
                                          left: leadingConstant - 4,
                                          bottom: textInset.bottom,
                                          right: textInset.right)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        CGSize(width: super.intrinsicContentSize.width,
               height: rectConfiguration.intrinsicHeight.multiline)
    }

    func textViewShouldBeginEditing(_: UITextView) -> Bool {
        outputDelegate?.textInputShouldBeginEditing(self) ?? true
    }

    func textViewDidEndEditing(_: UITextView) {
        outputDelegate?.textInputdDidEndEditing(self)
    }

    func textView(_: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        placeholderLabel.isHidden = !(range.location == .zero && text.isEmpty)
        return outputDelegate?.textInput(self,
                                         shouldChangeCharactersIn: range,
                                         replacementString: text) ?? true
    }
}

extension ELTextView: ELTextInput {
    var input: UIView? {
        get { inputView }
        set { inputView = newValue }
    }

    var accesory: UIView? {
        get { inputAccessoryView }
        set { inputAccessoryView = newValue }
    }

    var enteredText: String? {
        get { text }
        set {
            if attributedTextMapper != nil {
                attributedText = attributedTextMapper?(newValue)
            } else {
                text = newValue
            }
            if let val = newValue {
                placeholderHidden = !val.isEmpty
            }
        }
    }

    var rightImageView: UIView? {
        get { nil }
        set {}
    }
}

extension ELTextView: ELTextInputConfigurable {
    func configureLayer(_ configuration: ELTextInputLayerConfiguration) {
        layer.borderColor = configuration.borderColor?.cgColor
        layer.borderWidth = configuration.borderWidth ?? .zero
        layer.cornerRadius = configuration.cornerRadius ?? .zero
    }

    func configureTraits(_ traits: ELTextFieldInputTraits) {
        isSecureTextEntry = traits.isSecureTextEntry
        keyboardType = traits.keyboardType
        textContentType = traits.contentType
        returnKeyType = traits.returnKeyType
        autocorrectionType = traits.autocorrectionType
        spellCheckingType = traits.spellCheckingType
        autocapitalizationType = traits.autocapitalizationType
    }

    func configureViewModel(_ viewModel: ELTextInputViewModel) {
        attributedTextMapper = viewModel.attributedTextMapper
        enteredText = viewModel.text
        if let attributedPlaceholderMapper = viewModel.attributedPlaceholderMapper {
            attributedPlaceholder = attributedPlaceholderMapper(viewModel.placeholder)
        } else {
            placeholder = viewModel.placeholder
        }
        updateState(viewModel.state)
    }

    func updateState(_ textFieldState: ELTextFieldState) {
        configureLayer(Configuration.layer(for: textFieldState))
    }
}
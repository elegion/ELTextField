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

    public weak var textInputDelegate: ELTextInputDelegate?

    var placeholderHidden: Bool {
        get { placeholderLabel.isHidden }
        set { placeholderLabel.isHidden = newValue }
    }

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)

        delegate = self
        addSubview(placeholderLabel)
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        let textInset = rectConfiguration.textInset ?? .zero
        let leadingConstant = textInset.left
        placeholderLabel.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: leadingConstant
        ).isActive = true
        let topConstant = textInset.top
        placeholderLabel.topAnchor.constraint(
            equalTo: topAnchor,
            constant: topConstant
        ).isActive = true
        let insets = UIEdgeInsets(
            top: topConstant,
            left: leadingConstant - 4,
            bottom: textInset.bottom,
            right: textInset.right
        )
        textContainerInset = insets
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        CGSize(
            width: super.intrinsicContentSize.width,
            height: rectConfiguration.containerHeight.multiline
        )
    }

    func textViewShouldBeginEditing(_: UITextView) -> Bool {
        textInputDelegate?.textInputShouldBeginEditing(self) ?? true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textInputDelegate?.textInputDidBeginEditing(self)
    }

    func textViewDidEndEditing(_: UITextView) {
        textInputDelegate?.textInputdDidEndEditing(self)
    }

    func textView(
        _: UITextView,
        shouldChangeTextIn range: NSRange,
        replacementText text: String
    ) -> Bool {
        placeholderLabel.isHidden = !(range.location == .zero && text.isEmpty)
        return textInputDelegate?.textInput(
            self,
            shouldChangeCharactersIn: range,
            replacementString: text
        ) ?? true
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        var rect = super.caretRect(for: position)
        func yPos(currentRect: CGRect, targetHeight: CGFloat) -> CGFloat {
            let diff = currentRect.height - targetHeight
            return currentRect.origin.y + diff / 2
        }
        switch Configuration.caretRect() {
        case .default:
            return rect
        case let .height(newHeight):
            return CGRect(
                x: rect.origin.x,
                y: yPos(currentRect: rect, targetHeight: newHeight),
                width: rect.width,
                height: newHeight
            )
        case let .width(newWidth):
            rect.size.width = newWidth
            return rect
        case let .size(newSize):
            return CGRect(
                x: rect.origin.x,
                y: yPos(currentRect: rect, targetHeight: newSize.height),
                width: newSize.width,
                height: newSize.height
            )
        case let .dynamic(modifier):
            return modifier(rect)
        }
    }
}

extension ELTextView: ELTextInputConfigurable {
    
    func configureLayer(_ configuration: ELTextInputLayerConfiguration) {
        layer.borderColor = configuration.borderColor?.cgColor
        layer.borderWidth = configuration.borderWidth ?? .zero
        layer.cornerRadius = configuration.cornerRadius ?? .zero
        backgroundColor = configuration.backgroundColor
        tintColor = configuration.caretColor
        rightImageView?.tintColor = configuration.tintColor
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

    func configureFont(_ configuration: ELTextInputFontConfiguration?) {
        font = configuration?.font
        textColor = configuration?.textColor
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
        UIView.animate(withDuration: CATransaction.animationDuration(), delay: .zero) {
            self.configureLayer(Configuration.layer(for: textFieldState))
        }
    }
    
    func configureRightItem(with container: ELRightViewContainer?) {
        #warning("Доделать")
    }
    
    func configureLeftItem(with container: ELLeftViewContainer?) {
        #warning("Доделать")
    }
}

//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation
import UIKit

class ELTextField<Configuration: ELTextFieldConfigurationProtocol>: UITextField, UITextFieldDelegate {
    
    var attributedTextMapper: ((String?) -> NSAttributedString?)?

    private var rectConfiguration: ELTextInputRectConfiguration {
        Configuration.rect()
    }

    weak var textInputDelegate: ELTextInputDelegate?

    private var rightItemAction: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)

        delegate = self
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var rightViewVisible: Bool {
        guard let rightImageView else {
            return false
        }
        let rightViewVisible = !rightImageView.isHidden
        return rightViewVisible && rightViewMode != .never
    }
    
    private var leftViewVisible: Bool {
        guard let leftImageView else {
            return false
        }
        let leftViewVisible = !leftImageView.isHidden
        return leftViewVisible && leftViewMode != .never
    }

    private func calculateRect(
        forBounds bounds: CGRect,
        insets: UIEdgeInsets?,
        leftPosition: ELLeftViewPosition?,
        rightPosition: ELRightViewPosition?,
        rightViewVisible: Bool,
        leftViewVisible: Bool
    ) -> CGRect {
        guard let insets else {
            return bounds
        }
        let rightTotalWidth: CGFloat = if let rightPosition, rightViewVisible {
            rightPosition.rightInset + rightPosition.size.width
        } else {
            0
        }
        let leftTotalWidth: CGFloat = if let leftPosition, leftViewVisible {
            leftPosition.leftInset + leftPosition.size.width
        } else {
            0
        }
        let imagesInsets = UIEdgeInsets(
            top: .zero,
            left: leftTotalWidth,
            bottom: .zero,
            right: rightTotalWidth
        )
        return bounds.inset(by: insets).inset(by: imagesInsets)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        calculateRect(
            forBounds: bounds,
            insets: rectConfiguration.textInset,
            leftPosition: rectConfiguration.leftViewPosition,
            rightPosition: rectConfiguration.rightViewPosition,
            rightViewVisible: rightViewVisible,
            leftViewVisible: leftViewVisible
        )
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        calculateRect(
            forBounds: bounds,
            insets: rectConfiguration.editingInset,
            leftPosition: rectConfiguration.leftViewPosition,
            rightPosition: rectConfiguration.rightViewPosition,
            rightViewVisible: rightViewVisible,
            leftViewVisible: leftViewVisible
        )
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        guard let leftViewPosition = rectConfiguration.leftViewPosition else {
            return bounds
        }
        let leftViewSize = leftViewPosition.size
        let xInset = leftViewPosition.leftInset
        let xPos = rectConfiguration.textInset?.left ?? .zero
        let yPos: CGFloat
        switch leftViewPosition {
        case let .absolute(topLeft, _):
            yPos = bounds.height - leftViewSize.height - topLeft.y
        case .centerHorizontally:
            yPos = bounds.height / 2 - leftViewSize.height / 2
        }
        let origin = CGPoint(x: xPos, y: yPos)
        return CGRect(
            origin: origin,
            size: leftViewSize
        )
    }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        guard let rightViewPosition = rectConfiguration.rightViewPosition else {
            return bounds
        }
        let rightViewSize = rightViewPosition.size
        let xInset = rectConfiguration.textInset?.right ?? .zero//rightViewPosition.rightInset
        let xPos = bounds.width - rightViewSize.width - xInset
        let yPos: CGFloat
        switch rightViewPosition {
        case let .absolute(topRight, _):
            yPos = bounds.height - rightViewSize.height - topRight.y
        case .centerHorizontally:
            yPos = bounds.height / 2 - rightViewSize.height / 2
        }
        let origin = CGPoint(x: xPos, y: yPos)
        return CGRect(
            origin: origin,
            size: rightViewSize
        )
    }

    override var intrinsicContentSize: CGSize {
        CGSize(
            width: super.intrinsicContentSize.width,
            height: rectConfiguration.containerHeight.singleline
        )
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        textInputDelegate?.textInput(self, canPerformAction: action, withSender: sender) ?? true
    }

    @discardableResult
    func textFieldShouldClear(_: UITextField) -> Bool {
        textInputDelegate?.textInputShouldClear(self) ?? true
    }

    func textFieldShouldBeginEditing(_: UITextField) -> Bool {
        textInputDelegate?.textInputShouldBeginEditing(self) ?? true
    }

    func textFieldDidBeginEditing(_: UITextField) {
        textInputDelegate?.textInputDidBeginEditing(self)
    }

    func textFieldDidEndEditing(_: UITextField) {
        textInputDelegate?.textInputdDidEndEditing(self)
    }

    func textField(
        _: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        textInputDelegate?.textInput(
            self,
            shouldChangeCharactersIn: range,
            replacementString: string
        ) ?? true
    }

    func textFieldShouldReturn(_: UITextField) -> Bool {
        textInputDelegate?.textInputShouldReturn(self) ?? true
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
    
    @objc
    private func didTapOnDelete() {
        didTapOnDeleteAction()
    }

    @objc
    private func didTapOnRightAction() {
        rightItemAction?()
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        textInputDelegate?.touchesBegan(in: self, touches: touches, with: event)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)

        textInputDelegate?.touchesMoved(in: self, touches: touches, with: event)
    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        textInputDelegate?.touchesEnded(in: self, touches: touches, with: event)
    }

    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)

        textInputDelegate?.touchesCancelled(in: self, touches: touches, with: event)
    }
}

extension ELTextField: ELTextInputConfigurable {

    func configureLayer(_ configuration: ELTextInputLayerConfiguration) {
        layer.borderColor = configuration.borderColor?.cgColor
        layer.borderWidth = configuration.borderWidth ?? .zero
        layer.cornerRadius = configuration.cornerRadius ?? .zero
        backgroundColor = configuration.backgroundColor ?? .clear
        tintColor = configuration.caretColor
        rightImageView?.tintColor = configuration.tintColor
        leftImageView?.tintColor = configuration.tintColor
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
        setLeftItem(with: viewModel.leftView)

        updateState(viewModel.state)
    }

    func configureRightItem(with container: ELRightViewContainer?) {
        setRightContainer(container)
    }
    
    func configureLeftItem(with container: ELLeftViewContainer?) {
        setLeftContainer(container)
    }
    
    func updateState(_ textFieldState: ELTextFieldState) {
        UIView.animate(withDuration: CATransaction.animationDuration(), delay: .zero) {
            self.configureLayer(Configuration.layer(for: textFieldState))
        }
    }

    private func didTapOnDeleteAction() {
        textFieldShouldClear(self)
    }
    
    private func setViewMode(from mode: ELRightItem.Mode) {
        switch mode {
        case let .system(systemViewMode):
            rightViewMode = systemViewMode
        }
    }
    
    private func setRightContainer(_ container: ELRightViewContainer?) {
        guard let container else {
            return
        }
        rightImageView = container.view
        rightViewMode = container.rightViewMode
        clearButtonMode = container.clearButtonMode
        isSecureTextEntry = container.isSecureTextEntry
    }
    
    private func setLeftContainer(_ container: ELLeftViewContainer?) {
        guard let container else {
            return
        }
        leftImageView = container.view
        leftViewMode = container.leftViewMode
    }
    
    private func setLeftItem(with leftView: UIView?) {
        guard let leftView else {
            return
        }
        self.leftImageView = leftView
    }
}

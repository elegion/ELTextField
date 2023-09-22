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
//    weak var customRightViewMode: ELRightViewMode?

    private var rightItemAction: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)

        delegate = self
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        guard let insets = rectConfiguration.textInset else {
            return bounds
        }
        return bounds.inset(by: insets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        guard let insets = rectConfiguration.editingInset else {
            return bounds
        }
        var insettedBounds = bounds.inset(by: insets)
        guard let rightPosition = rectConfiguration.rightViewPosition, rightImageView?.isHidden == false else {
            return insettedBounds
        }
        insettedBounds.size.width = insettedBounds.width - (rightPosition.rightInset + rightPosition.size.width)
        return insettedBounds
    }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        guard let rightViewPosition = rectConfiguration.rightViewPosition else {
            return bounds
        }
        let rightViewSize = rightViewPosition.size
        let xInset = rightViewPosition.rightInset
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
    
    private func setLeftItem(with leftView: UIView?) {
        guard let leftView else {
            return
        }
        self.leftImageView = leftView
    }
    
    private func setRightItem(with rightItem: ELRightItem?) {
        guard let rightItem else {
            return
        }
        switch rightItem {
        case let .image(image, mode):
            let imageView = UIImageView(image: image)
            imageView.contentMode = .center
            rightImageView = imageView
            setViewMode(from: mode)
        case let .action(image, mode, behavior):
            let button = UIButton(type: .system)
            if #available(iOS 14.0, *) {
                let action: UIAction
                switch behavior {
                case .delete:
                    action = UIAction {
                        [weak self] _ in

                        self?.didTapOnDeleteAction()
                    }
                case let .custom(tapAction):
                    action = UIAction {
                        _ in

                        tapAction()
                    }
                }
                button.addAction(action, for: .touchUpInside)
            } else {
                switch behavior {
                case .delete:
                    button.addTarget(self, action: #selector(didTapOnDelete), for: .touchUpInside)
                case let .custom(action):
                    rightItemAction = action
                    button.addTarget(self, action: #selector(didTapOnRightAction), for: .touchUpInside)
                }
            }
            button.setImage(image, for: .normal)
            rightImageView = button
            setViewMode(from: mode)
        case let .custom(view, mode):
            rightImageView = view
            setViewMode(from: mode)
        case let .secure(showImage, hideImage, mode):
            let button = UIButton()
            if #available(iOS 14.0, *) {
                button.addAction(UIAction {
                    [weak self, weak button] _ in
                    
                    self?.isSecureTextEntry.toggle()
                    button?.isSelected.toggle()
                }, for: .touchUpInside)
            }
            rightImageView = button
            button.setImage(showImage, for: .normal)
            button.setImage(hideImage, for: .selected)
            setViewMode(from: mode)
        default:
            break
        }
        clearButtonMode = rightItem.isSystemClear ? .whileEditing : .never
    }
}

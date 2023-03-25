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

    public weak var textInputDelegate: ELTextInputDelegate?
    var behaviorAction: ((ELTextFieldBehaviorAction) -> Void)?

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
        return bounds.inset(by: insets)
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
            height: rectConfiguration.intrinsicHeight.singleline
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
        behaviorAction?(.startEditing)
    }

    func textFieldDidEndEditing(_: UITextField) {
        behaviorAction?(.endEditing)
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
}

extension ELTextField: ELTextInputConfigurable {
    
    func configureLayer(_ configuration: ELTextInputLayerConfiguration) {
        layer.borderColor = configuration.borderColor?.cgColor
        layer.borderWidth = configuration.borderWidth ?? .zero
        layer.cornerRadius = configuration.cornerRadius ?? .zero
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

    func configureViewModel(_ viewModel: ELTextInputViewModel) {
        attributedTextMapper = viewModel.attributedTextMapper
        enteredText = viewModel.text
        if let attributedPlaceholderMapper = viewModel.attributedPlaceholderMapper {
            attributedPlaceholder = attributedPlaceholderMapper(viewModel.placeholder)
        } else {
            placeholder = viewModel.placeholder
        }
        setRightItem(with: viewModel.rightItem)

        updateState(viewModel.state)
    }

    func updateState(_ textFieldState: ELTextFieldState) {
        UIView.animate(withDuration: CATransaction.animationDuration(), delay: .zero) {
            self.configureLayer(Configuration.layer(for: textFieldState))
        }
    }

    private func didTapOnDeleteAction() {
        textFieldShouldClear(self)
    }

    private func setRightItem(with rightItem: ELRightItem?) {
        guard let rightItem else {
            rightViewMode = .never
            return
        }
        switch rightItem {
        case let .image(image, mode):
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            rightImageView = imageView
            rightViewMode = mode
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
            rightViewMode = mode
        case let .custom(view, mode):
            rightImageView = view
            rightViewMode = mode
        default:
            break
        }
        clearButtonMode = rightItem.isSystemClear ? .whileEditing : .never
    }
}

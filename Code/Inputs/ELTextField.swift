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

    public weak var outputDelegate: ELTextInputOutput?
    var behaviorAction: ((ELTextFieldBehaviorAction) -> Void)?

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
        return CGRect(origin: origin,
                      size: rightViewSize)
    }

    override var intrinsicContentSize: CGSize {
        CGSize(width: super.intrinsicContentSize.width,
               height: rectConfiguration.intrinsicHeight.singleline)
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        outputDelegate?.textInput(self, canPerformAction: action, withSender: sender) ?? true
    }

    @discardableResult
    func textFieldShouldClear(_: UITextField) -> Bool {
        outputDelegate?.textInputShouldClear(self) ?? true
    }

    func textFieldShouldBeginEditing(_: UITextField) -> Bool {
        return outputDelegate?.textInputShouldBeginEditing(self) ?? true
    }

    func textFieldDidBeginEditing(_: UITextField) {
        behaviorAction?(.startEditing)
    }

    func textFieldDidEndEditing(_: UITextField) {
        behaviorAction?(.endEditing)
        outputDelegate?.textInputdDidEndEditing(self)
    }

    func textField(_: UITextField,
                   shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        outputDelegate?.textInput(self,
                                  shouldChangeCharactersIn: range,
                                  replacementString: string) ?? true
    }

    func textFieldShouldReturn(_: UITextField) -> Bool {
        outputDelegate?.textInputShouldReturn(self) ?? true
    }
    
    @objc private func didTapOnDelete() {
        
    }
}

extension ELTextField: ELTextInput {
    var enteredText: String? {
        get { text }
        set {
            if attributedTextMapper != nil {
                attributedText = attributedTextMapper?(newValue)
            } else {
                text = newValue
            }
        }
    }

    var input: UIView? {
        get { inputView }
        set { inputView = newValue }
    }

    var accesory: UIView? {
        get { inputAccessoryView }
        set { inputAccessoryView = newValue }
    }

    var rightImageView: UIView? {
        get { rightView }
        set { rightView = newValue }
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
        setRightImageView(with: viewModel.rightButtonItem)

        clearButtonMode = viewModel.showClearButton ? .whileEditing : .never
        updateState(viewModel.state)
    }

    func updateState(_ textFieldState: ELTextFieldState) {
        configureLayer(Configuration.layer(for: textFieldState))
    }

    private func didTapOnDeleteAction() {
        textFieldShouldClear(self)
    }

    private func setRightImageView(with item: ELRightItem?) {
        guard let item = item else {
            rightViewMode = .never
            return
        }
        switch item {
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
                case .custom:
                    #warning("Не обработано")
                    break
                }
            }
            button.setImage(image, for: .normal)
            rightImageView = button
            rightViewMode = mode
        case let .custom(view, mode):
            rightImageView = view
            rightViewMode = mode
        }
    }
}

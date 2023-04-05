//
//  TLTextFieldContainer.swift
//  ELTextFieldDemo
//
//  Created by viktor.volkov on 02.04.2023.
//  Copyright © 2023 E-legion. All rights reserved.
//

import Foundation
import ELTextField
import UIKit
import Swissors

final class TLTextFieldContainer: ELTextFieldGenericContainer<TLTextFieldConfiguration, TLTextFieldBehavior> {
    
    private enum Layout {
        static let horizontalInsets: CGFloat = 16
    }
    
    private enum LabelAppearance {
        case large
        case small
    }
    
    private let floatingPlaceholderLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = false
        label.backgroundColor = .clear
        label.layer.anchorPoint = .zero
        label.layer.position = .zero
        return label
    }()
    
    private var currentAppearance = LabelAppearance.large
    
    override init(type: ELTextInputType = .singleline) {
        super.init(type: type)

        addSubview(floatingPlaceholderLabel)
        sendSubviewToBack(floatingPlaceholderLabel)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tapGesture)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(floatingPlaceholderLabel)
        sendSubviewToBack(floatingPlaceholderLabel)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tapGesture)
    }
    
    private func updatePlaceholder(appearance: LabelAppearance) {
        switch appearance {
        case .small:
            floatingPlaceholderLabel.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
        case .large:
            floatingPlaceholderLabel.transform = .identity
        }
        floatingPlaceholderLabel.sizeToFit()
        let offset = appearance == .small
        ? (floatingPlaceholderLabel.frame.height + 60 / 10)
        : floatingPlaceholderLabel.frame.height / 2
        let floatingPlaceholderSize: CGSize
        if appearance == .small {
            floatingPlaceholderSize = floatingPlaceholderLabel.frame.size
        } else {
            let viewWidth = frame.width
            let placeholderWidth = viewWidth - Layout.horizontalInsets * 2 - 8
            floatingPlaceholderSize = CGSize(
                width: placeholderWidth,
                height: floatingPlaceholderLabel.frame.height
            )
        }
        floatingPlaceholderLabel.frame = .init(
            origin: .init(
                x: Layout.horizontalInsets,
                y: 60 / 2 - offset
            ),
            size: floatingPlaceholderSize
        )
    }

    override func startEditing(in behavior: ELTextFieldBehavior) {
        updateAppearance(.small)
    }

    override func endEditing(in behavior: ELTextFieldBehavior) {
        updateAppearance(behavior.value.isEmpty ? .large : .small)
    }

    override func setBehavior(_ behavior: TLTextFieldBehavior?) {
        super.setBehavior(behavior)

        floatingPlaceholderLabel.attributedText = behavior?
            .floatingPlaceholder?
            .attribute
            .with(font: .systemFont(ofSize: 15, weight: .regular))
            .with(foregroundColor: R.color.gray919195())
            .build()
        updatePlaceholder(appearance: currentAppearance)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        updatePlaceholder(appearance: currentAppearance)
    }
    
    @objc
    private func didTap() {
        _ = becomeFirstResponder()
    }
    
    private func updateAppearance(_ appearance: LabelAppearance) {
        UIView.animate(withDuration: CATransaction.animationDuration()) {
            self.currentAppearance = appearance
            self.updatePlaceholder(appearance: appearance)
        }
    }
}

extension TLTextFieldContainer: Configurable {
    
    func set(model: TLTextFieldBehavior) {
        self.setBehavior(model)
    }
}

final class MailBehavior: TLTextFieldBehavior {
    
    init(mail: String = "") {
        let mapper: (String?) -> NSAttributedString? = {
            $0?.attribute.with(font: .systemFont(ofSize: 15, weight: .bold)).build()
        }
        let rightImage = ELRightItem.image(image: UIImage(systemName: "checkmark"), mode: .always)
        super.init(text: mail,
                   textMapper: mapper,
                   placeholder: "Почта",
                   placeholderMapper: mapper,
                   rightItem: rightImage,
                   validation: .init(validator: ELMailTextFieldValidator(),
                                     rule: .onEndEditing))
    }
}

class TLTextFieldBehavior: ELDefaultTextFieldBehavior {
    
    let floatingPlaceholder: String?
    
    override init(text: String? = nil,
                  textMapper: ((String?) -> NSAttributedString?)? = nil,
                  placeholder: String? = nil,
                  placeholderMapper: ((String?) -> NSAttributedString?)? = nil,
                  rightItem: ELRightItem? = nil,
                  mask: ELTextFieldInputMask = ELDefaultTextMask(),
                  traits: ELTextFieldInputTraits = ELDefaultTextFieldInputTraits(),
                  validation: ELTextFieldValidation = .default) {
        let mapper: (String?) -> NSAttributedString? = {
            $0?.attribute.with(font: .systemFont(ofSize: 15, weight: .regular)).with(foregroundColor: R.color.black1F22229()).build()
        }
        self.floatingPlaceholder = placeholder
        super.init(
            text: text,
            textMapper: mapper,
            placeholder: nil,
            placeholderMapper: nil,
            rightItem: .action(image: UIImage(systemName: "xmark.circle"),
                               mode: .always,
                               behavior: .delete),
            mask: mask,
            traits: traits,
            validation: validation
        )
    }
}

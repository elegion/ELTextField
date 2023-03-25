//
//  PNFloatingPlaceholderTextFiedContainer.swift
//  ELTextFieldDemo
//
//  Created by viktor.volkov on 25.03.2023.
//  Copyright © 2023 E-legion. All rights reserved.
//

import ELTextField
import Foundation
import UIKit

final class PNFloatingPlaceholderTextFieldContainer: ELDefaultTextFieldGenericContainer<PNFloatingPlaceholderTextFieldConfiguration> {

    private let floatingLabel = UILabel()
    private let separatorView = SeparatorView()

    override public init(type: ELTextInputType = .singleline) {
        super.init(type: type)

        addSubview(floatingLabel)
        addSubview(separatorView)
        floatingLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(11)
        }
        separatorView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func setBehavior(_ behavior: ELDefaultTextFieldBehavior?) {
        super.setBehavior(behavior)

        updateFloatingLabelAppearance(isVisible: !(behavior?.value.isEmpty ?? true))
        floatingLabel.attributedText = behavior?
            .placeholder?
            .attribute
            .with(font: .systemFont(ofSize: 12, weight: .regular))
            .with(foregroundColor: R.color.gray919195()).build()
    }

    private func updateFloatingLabelAppearance(isVisible: Bool) {
        UIView.animate(withDuration: CATransaction.animationDuration()) {
            self.floatingLabel.alpha = isVisible ? 1 : .zero
        }
    }

    override func container(_ behavior: ELTextFieldBehavior, changedText text: String) {
        updateFloatingLabelAppearance(isVisible: !text.isEmpty)
    }
}

final class SeparatorView: UIView {

    override var intrinsicContentSize: CGSize {
        CGSize(width: super.intrinsicContentSize.width, height: 0.5)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = R.color.grayCCCCCE()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

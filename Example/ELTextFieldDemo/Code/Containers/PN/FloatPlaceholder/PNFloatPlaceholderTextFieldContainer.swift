//
//  PNFloatPlaceholderTextFieldContainer.swift
//  ELTextFieldDemo
//
//  Created by viktor.volkov on 26.03.2023.
//  Copyright © 2023 E-legion. All rights reserved.
//

import Foundation
import ELTextField
import UIKit

final class PNFloatPlaceholderTextFieldContainer: ELTextFieldGenericContainer<PNTopPlaceholderTextFieldConfiguration, PNFloatPlaceholderTextFieldBehavior> {
    
    private enum LabelAppearance {
        case large
        case small
    }
    
    private enum Layout {
        static let horizontalInsets: CGFloat = 16
    }
    
    private var currentAppearance = LabelAppearance.large
    
    private lazy var selectedParameterLabel: RoundInsetLabel = {
        let view = RoundInsetLabel()
        view.backgroundColor = R.color.yellowFCE66F()
        view.insets = UIEdgeInsets(vertical: 4, horizontal: 12)
        return view
    }()
    
    private let floatingPlaceholder: UILabel = {
        let label = UILabel()
        label.layer.anchorPoint = .zero
        label.layer.position = .zero
        return label
    }()
    
    private let separatorView = SeparatorView()
    
    override init(type: ELTextInputType = .singleline) {
        super.init(type: type)
        
        addSubview(floatingPlaceholder)
        addSubview(selectedParameterLabel)
        addSubview(separatorView)
        selectedParameterLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(Layout.horizontalInsets)
            $0.centerY.equalToSuperview()
        }
        separatorView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tapGesture)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(floatingPlaceholder)
        addSubview(selectedParameterLabel)
        addSubview(separatorView)
        selectedParameterLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(Layout.horizontalInsets)
            $0.centerY.equalToSuperview()
        }
        separatorView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tapGesture)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func setBehavior(_ behavior: PNFloatPlaceholderTextFieldBehavior?) {
        super.setBehavior(behavior)
        
        floatingPlaceholder.attributedText = behavior?
            .floatingPlaceholder?
            .attribute
            .with(font: .systemFont(ofSize: 17, weight: .regular))
            .with(foregroundColor: R.color.gray919195())
            .build()
        selectedParameterLabel.text = behavior?.anyValueGender.text
        selectedParameterLabel.backgroundColor = R.color.grayF1F1F4()
        //            selectedParameterView.setAnyText(searchBehavior.anyValueGender.text)
        //            searchBehavior.updateSelectedValueText = {
        //                [weak self] newText in
        //
        //                self?.updateSelectedParameterAppearance(text: newText)
        //            }
        //            selectedParameterView.onClearTap = {
        //                [weak searchBehavior] in
        //
        //                searchBehavior?.onClearTap?()
        //                searchBehavior?.updateText("")
        //            }
        updatePlaceholder(appearance: currentAppearance)
        updateSelectedParameterAppearance(text: behavior?.value)
    }
    
    private func updatePlaceholder(appearance: LabelAppearance) {
        switch appearance {
        case .small:
            floatingPlaceholder.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
        case .large:
            floatingPlaceholder.transform = .identity
        }
        textInput.alpha = appearance == .small ? 1 : .zero
        floatingPlaceholder.sizeToFit()
        selectedParameterLabel.sizeToFit()
        let offset = appearance == .small
        ? (floatingPlaceholder.frame.height + 60 / 10)
        : floatingPlaceholder.frame.height / 2
        let floatingPlaceholderSize: CGSize
        if appearance == .small {
            floatingPlaceholderSize = floatingPlaceholder.frame.size
        } else {
            let viewWidth = frame.width
            let placeholderWidth = viewWidth - selectedParameterLabel.frame.width - Layout.horizontalInsets * 2 - 8
            floatingPlaceholderSize = CGSize(
                width: placeholderWidth,
                height: floatingPlaceholder.frame.height
            )
        }
        floatingPlaceholder.frame = .init(
            origin: .init(
                x: Layout.horizontalInsets,
                y: 60 / 2 - offset
            ),
            size: floatingPlaceholderSize
        )
    }
    
    @objc
    private func didTap() {
        _ = becomeFirstResponder()
    }
    
    private func updateSelectedParameterAppearance(text: String?) {
        guard let text, !text.isEmpty else {
            return
        }
        selectedParameterLabel.text = text
        selectedParameterLabel.sizeToFit()
        updatePlaceholder(appearance: currentAppearance)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        updatePlaceholder(appearance: currentAppearance)
    }
    
    override func startEditing(in behavior: ELTextFieldBehavior) {
        UIView.animate(withDuration: CATransaction.animationDuration()) {
            self.currentAppearance = .small
            self.updatePlaceholder(appearance: .small)
        }
    }
    
    override func endEditing(in behavior: ELTextFieldBehavior) {
        updateSelectedParameterAppearance(text: behavior.value)
        if behavior.value.isEmpty {
            selectedParameterLabel.text = "Любое"
            selectedParameterLabel.backgroundColor = R.color.grayF1F1F4()
        } else {
            selectedParameterLabel.text = behavior.value
            selectedParameterLabel.backgroundColor = R.color.yellowFCE66F()
        }
        UIView.animate(withDuration: CATransaction.animationDuration()) {
            self.currentAppearance = .large
            self.updatePlaceholder(appearance: .large)
        }
    }
    
    override func container(_ behavior: ELTextFieldBehavior, changedState: ELTextFieldState) {
        switch changedState {
        case .error:
            separatorView.backgroundColor = .red
        default:
            separatorView.backgroundColor = R.color.grayCCCCCE()
        }
    }
}

extension PNFloatPlaceholderTextFieldContainer: Configurable {
    
    func set(model: PNFloatPlaceholderTextFieldBehavior) {
        setBehavior(model)
    }
}

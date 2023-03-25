//
//  PNSearchTextFieldBehavior.swift
//  ELTextFieldDemo
//
//  Created by viktor.volkov on 25.03.2023.
//  Copyright © 2023 E-legion. All rights reserved.
//

import ELTextField
import Foundation
import UIKit

public class PNSearchTextFieldBehavior: ELDefaultTextFieldBehavior {
    public enum AnyValueGender {
        case male
        case female
        case it
        case many
        case notMatter
        
        var text: String {
            "любая"
        }
    }
    
    let floatingPlaceholder: String?
    let anyValueGender: AnyValueGender
    //    var updateSelectedValueText: Closure.In<String?>?
    //    public var onClearTap: Closure.Void?
    
    public init(
        text: String? = nil,
        textMapper: ((String?) -> NSAttributedString?)? = nil,
        floatingPlaceholder: String? = nil,
        anyValueGender: AnyValueGender,
        placeholderMapper _: ((String?) -> NSAttributedString?)? = nil,
        rightButtonItem _: ELRightItem? = nil,
        showClearButton _: Bool = false,
        mask: ELTextFieldInputMask = ELDefaultTextMask(),
        traits: ELTextFieldInputTraits = ELDefaultTextFieldInputTraits(),
        validation: ELTextFieldValidation = .init(validator: ELMailTextFieldValidator(), rule: .onChange)
    ) {
        self.floatingPlaceholder = floatingPlaceholder
        self.anyValueGender = anyValueGender
        let formattedText = mask.maskedText(from: text)
        super.init(
            text: formattedText,
            textMapper: textMapper,
            placeholder: nil,
            placeholderMapper: nil,
            rightItem: nil,
            mask: mask,
            traits: traits,
            validation: validation
        )
    }
    
    override public func updateText(_ newText: String?) {
        super.updateText(newText)
        
        //        updateSelectedValueText?(newText)
    }
}

public struct PNSearchTextFieldContainerModel: Identifiable, Hashable {
    public var id: UUID
    let behavior: PNSearchTextFieldBehavior
    
    public init(
        id: UUID = UUID(),
        behavior: PNSearchTextFieldBehavior
    ) {
        self.id = id
        self.behavior = behavior
    }
}

final class PNSearchTextFieldContainer: ELTextFieldGenericContainer<PNFloatingPlaceholderTextFieldConfiguration, PNSearchTextFieldBehavior> {
    private enum LabelAppearance {
        case large
        case small
    }
    
    private enum Layout {
        static let horizontalInsets: CGFloat = 16
    }
    
    private var currentAppearance = LabelAppearance.large
    
    private lazy var selectedParameterLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .yellow
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
    
    override public func setBehavior(_ behavior: PNSearchTextFieldBehavior?) {
        super.setBehavior(behavior)
        
        floatingPlaceholder.attributedText = behavior?
            .floatingPlaceholder?
            .attribute
            .with(font: .systemFont(ofSize: 17, weight: .regular))
            .with(foregroundColor: R.color.gray919195())
            .build()
        selectedParameterLabel.text = behavior?.anyValueGender.text
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
            //            selectedParameterView.configure(with: .any)
            return
        }
        //        selectedParameterView.configure(with: .selected(text: text))
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
        selectedParameterLabel.text = behavior.value
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

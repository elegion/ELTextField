//
//  SeparatorView.swift
//  ELTextFieldDemo
//
//  Created by viktor.volkov on 26.03.2023.
//  Copyright © 2023 E-legion. All rights reserved.
//

import Foundation
import UIKit

final class SeparatorView: UIView {

    override var intrinsicContentSize: CGSize {
        CGSize(width: super.intrinsicContentSize.width, height: 1)
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

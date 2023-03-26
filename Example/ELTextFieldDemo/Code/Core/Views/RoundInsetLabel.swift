//
//  RoundInsetLabel.swift
//  ELTextFieldDemo
//
//  Created by viktor.volkov on 26.03.2023.
//  Copyright © 2023 E-legion. All rights reserved.
//

import Foundation
import UIKit

final class RoundInsetLabel: UILabel {
    
    var insets: UIEdgeInsets = .zero {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = min(frame.width, frame.height) / 2
        clipsToBounds = true
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        guard !(text?.isEmpty ?? true) else {
            return super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        }

        let bounds = bounds.inset(by: insets)
        let result = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)

        return result.inset(by: insets.inverted)
    }
}

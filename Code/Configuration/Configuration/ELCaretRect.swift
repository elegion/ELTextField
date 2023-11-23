//
//  ELCaretRect.swift
//  
//
//  Created by viktor.volkov on 03.10.2023.
//

import Foundation

/// Изменение размера каретки
public enum ELCaretRect {
    
    case `default`
    case height(CGFloat)
    case width(CGFloat)
    case size(CGSize)
    case dynamic(modifier: ((CGRect) -> CGRect))
}

//
//  ELContainerHeight.swift
//  
//
//  Created by viktor.volkov on 13.06.2023.
//

import Foundation

/// Высота контейнера ввода
public struct ELContainerHeight {
    /// Высота однострочного контейнера
    let singleline: CGFloat
    /// Высота многострочного контейнера
    let multiline: CGFloat
    
    /// Создает контейнер с различными значениями высот для однострочного и многострочного поля ввода
    ///
    /// - Parameters:
    ///   - singleline: Высота однострочного контейнера
    ///   - multiline: Высота многострочного контейнера
    public init(
        singleline: CGFloat,
        multiline: CGFloat
    ) {
        self.singleline = singleline
        self.multiline = multiline
    }
    
    /// Создает контейнер с одинаковым значением `singleline` и `multiline`
    ///
    /// - Parameter value: Высота контейнеров
    public init(value: CGFloat) {
        self.init(singleline: value, multiline: value)
    }
}

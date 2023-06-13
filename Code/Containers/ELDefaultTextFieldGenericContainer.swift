//
//  File.swift
//  
//
//  Created by viktor.volkov on 13.06.2023.
//

import Foundation

/// Контейнер, у которого Поведение является дефолтным
public typealias ELDefaultTextFieldGenericContainer<
    C: ELTextFieldConfigurationProtocol
> = ELTextFieldGenericContainer<C, ELDefaultTextFieldBehavior>

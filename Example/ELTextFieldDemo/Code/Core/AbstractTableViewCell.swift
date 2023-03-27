//
//  AbstractTableViewCell.swift
//  ELTextFieldDemo
//
//  Created by viktor.volkov on 26.03.2023.
//  Copyright © 2023 E-legion. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

final class AbstractTableViewCell<View: UIView>: UITableViewCell, Configurable where View: Configurable {
    
    private let view = View()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(view)
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(model: View.Model) {
        view.set(model: model)
    }
}
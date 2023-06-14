//
//  TutorialViewController.swift
//  ELTextFieldDemo
//
//  Created by viktor.volkov on 14.06.2023.
//  Copyright © 2023 E-legion. All rights reserved.
//

import Foundation
import UIKit
import ELTextField

class TutorialViewController: UIViewController {
    
    private let container = BaseTextFieldContainer(type: .singleline)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(container)
        container.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}

//
//  ViewController.swift
//  ELTextFieldDemo
//
//  Created by viktor.volkov on 25.03.2023.
//

import UIKit
import ELTextField
import SnapKit

class ViewController: UIViewController {
    
    private var someBehavior = ELDefaultTextFieldBehavior(rightItem: .image(image: UIImage(systemName: "xmark"),
                                                                            mode: .always))
    private var someTextField = ELTextFieldGenericContainer<SimplestConfiguration>(type: .singleline)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        view.addSubview(someTextField)
        someTextField.setBehavior(someBehavior)
        someTextField.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24)
        }
    }
}

struct SimplestConfiguration: ELTextFieldConfigurationProtocol {
    
    static func layer(for state: ELTextField.ELTextFieldState) -> ELTextField.ELTextInputLayerConfiguration {
        switch state {
        case .default:
            return .init(borderColor: .black, borderWidth: 1, cornerRadius: 8, tintColor: .black)
        case .error:
            return .init(borderColor: .black, borderWidth: 1, cornerRadius: 8, tintColor: .green)
        case .editing:
            return .init(borderColor: .green, borderWidth: 1, cornerRadius: 8, tintColor: .green)
        case .disabled:
            return .init(borderColor: .gray, borderWidth: 1, cornerRadius: 8, tintColor: .green)
        }
    }
    
    static func rect() -> ELTextField.ELTextInputRectConfiguration {
        .init(textInset: UIEdgeInsets(top: .zero, left: 16, bottom: .zero, right: .zero),
              rightViewPosition: .centerHorizontally(rightInset: 16, size: CGSize(width: 16, height: 16)),
              intrinsicHeight: .init(singleline: 60))
    }
}

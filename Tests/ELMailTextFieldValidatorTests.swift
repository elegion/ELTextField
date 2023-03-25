//
//  ELMailTextFieldValidatorTests.swift
//  
//
//  Created by viktor.volkov on 25.03.2023.
//

import XCTest
@testable import ELTextField

final class ELMailTextFieldValidatorTests: XCTestCase {

    func testMail() throws {
        let validator = ELMailTextFieldValidator()
        XCTAssertEqual(false, validator.isValid(text: nil))
        XCTAssertEqual(false, validator.isValid(text: ""))
        XCTAssertEqual(false, validator.isValid(text: "test"))
        XCTAssertEqual(false, validator.isValid(text: "test@aaa"))
        XCTAssertEqual(true, validator.isValid(text: "vvlkv@icloud.com"))
        XCTAssertEqual(false, validator.isValid(text: "test@aaa.com."))
    }
}

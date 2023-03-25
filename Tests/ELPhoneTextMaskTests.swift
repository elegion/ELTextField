//
//  ELPhoneTextMaskTests.swift
//
//
//  Created by viktor.volkov on 25.03.2023.
//

@testable import ELTextField
import XCTest

final class ELPhoneTextMaskTests: XCTestCase {

    func testMask1() throws {
        let simplePhoneTextMask = ELPhoneTextMask(
            phoneCode: "+7",
            inputMask: "$ (###) ### ## ##",
            outputMask: "$##########"
        )
        XCTAssertEqual(simplePhoneTextMask.maskedText(from: "9254293322"), "+7 (925) 429 33 22")
        XCTAssertEqual(simplePhoneTextMask.rawText(from: "+7 (925) 429 33 22"), "+79254293322")
        XCTAssertEqual(simplePhoneTextMask.maskedText(from: "925429332298123981231"), "+7 (925) 429 33 22")
        XCTAssertEqual(simplePhoneTextMask.maskedText(from: ""), "")
        XCTAssertEqual(simplePhoneTextMask.maskedText(from: "9"), "+7 (9")
    }

    func testMask2() throws {
        let simplePhoneTextMask = ELPhoneTextMask(
            phoneCode: "+7",
            inputMask: "$ (###) ### ####",
            outputMask: "$##########"
        )
        XCTAssertEqual(simplePhoneTextMask.maskedText(from: "9254293322"), "+7 (925) 429 3322")
        XCTAssertEqual(simplePhoneTextMask.maskedText(from: "925429332298123981231"), "+7 (925) 429 3322")
        XCTAssertEqual(simplePhoneTextMask.maskedText(from: ""), "")
        XCTAssertEqual(simplePhoneTextMask.maskedText(from: "9"), "+7 (9")
    }

    func testMask3() throws {
        let simplePhoneTextMask = ELPhoneTextMask(
            phoneCode: "8",
            inputMask: "$ ### ### ####",
            outputMask: "$##########"
        )
        XCTAssertEqual(simplePhoneTextMask.maskedText(from: "9254293322"), "8 925 429 3322")
        XCTAssertEqual(simplePhoneTextMask.rawText(from: "8 925 429 3322"), "89254293322")
        XCTAssertEqual(simplePhoneTextMask.maskedText(from: "925429332298123981231"), "8 925 429 3322")
        XCTAssertEqual(simplePhoneTextMask.maskedText(from: ""), "")
        XCTAssertEqual(simplePhoneTextMask.maskedText(from: "9"), "8 9")
    }
}

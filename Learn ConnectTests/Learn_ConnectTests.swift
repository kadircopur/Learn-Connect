//
//  Learn_ConnectTests.swift
//  Learn ConnectTests
//
//  Created by kadir on 23.11.2024.
//

import XCTest
@testable import Learn_Connect


final class AuthSignUpTest: XCTestCase {
    var authService: AuthService!

    override func setUp() {
        super.setUp()
        authService = AuthService.shared
    }

    override func tearDown() {
        authService = nil
        super.tearDown()
    }

    func testSignupWithValidCredentials() {
        authService.signUp(userEmail: "valid@example.com", password: "validpassword", username: "") { result in
            switch result {
            case .success(_):
                XCTAssertTrue(true, "Signup should succeed with valid credentials.")
            case .failure(_):
                XCTAssertTrue(false, "Signup should succeed with valid credentials.")
            }
        }
    }

    func testSignupWithInvalidCredentials() {
        authService.signUp(userEmail: "invalid@example.com", password: "invalidvalidpassword", username: "") { result in
            switch result {
            case .success(_):
                XCTAssertTrue(false, "Signup should succeed with valid credentials.")
            case .failure(_):
                XCTAssertTrue(true, "Signup should succeed with valid credentials.")
            }
        }
    }
}


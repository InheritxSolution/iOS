//
//  LoginViewModelTests.swift
//  Inheritx Solutions
//
//  Created by Inheritx on 02/05/26.
//  Copyright © 2026 Inheritx Solutions. All rights reserved.
//

import XCTest

@testable import app

final class LoginViewModelTests: XCTestCase {
    
    var sut: LoginViewModel!
    var mockRepository: MockAuthRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockAuthRepository()
        sut = LoginViewModel(authRepository: mockRepository)
    }
    
    override func tearDown() {
        sut = nil
        mockRepository = nil
        super.tearDown()
    }
    
    func testLogin_WhenSuccessful_UpdatesStateToSuccess() async {
        // Given
        let expectedUser = User(id: "1", email: "test@inheritx.com", isSignupComplete: true)
        mockRepository.result = .success(expectedUser)
        
        let expectation = XCTestExpectation(description: "State should change to success")
        
        sut.onStateChange = { state in
            if case .success(let user) = state {
                XCTAssertEqual(user.id, expectedUser.id)
                expectation.fulfill()
            }
        }
        
        // When
        sut.login(email: "test@inheritx.com", password: "password123")
        
        // Then
        await fulfillment(of: [expectation], timeout: 1.0)
        XCTAssertTrue(mockRepository.loginCalled)
    }
    
    func testLogin_WhenFailed_UpdatesStateToError() async {
        // Given
        mockRepository.result = .failure(.unauthorized)
        
        let expectation = XCTestExpectation(description: "State should change to error")
        
        sut.onStateChange = { state in
            if case .error(let message) = state {
                XCTAssertFalse(message.isEmpty)
                expectation.fulfill()
            }
        }
        
        // When
        sut.login(email: "test@inheritx.com", password: "wrongpassword")
        
        // Then
        await fulfillment(of: [expectation], timeout: 1.0)
    }
    
    func testLogin_WithInvalidEmail_DoesNotCallRepository() {
        // When
        sut.login(email: "invalid-email", password: "password")
        
        // Then
        XCTAssertFalse(mockRepository.loginCalled)
        if case .error(let message) = sut.state {
            XCTAssertEqual(message, "Please enter a valid email address".localized)
        } else {
            XCTFail("Should be in error state")
        }
    }
}

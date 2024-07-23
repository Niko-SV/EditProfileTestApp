//
//  BirthdayViewModelTests.swift
//  EditProfileTests
//
//  Created by NikoS on 23.07.2024.
//

import XCTest
@testable import EditProfile

class MockAgeValidator: AgeValidator {
    var isValid = false
    
    override func isAgeValid(selectedDate: Date) -> Bool {
        return isValid
    }
}

final class BirthdayViewModelTests: XCTestCase {
    
    func testOnSelectBirthdayDate_withNilDate() {
            let ageValidator = MockAgeValidator()
            let viewModel = BirthdayViewModel(ageValidator: ageValidator)
            
            let expectation = self.expectation(description: "Completion handler called")
            expectation.isInverted = true
            
            viewModel.onSelectBirthdayDate(selectedDate: nil) { _ in
                expectation.fulfill()
            }
            
            waitForExpectations(timeout: 1.0, handler: nil)
        }
    
    func testOnSelectBirthdayDate_withValidDate() {
            let ageValidator = MockAgeValidator()
            ageValidator.isValid = true
        
            let viewModel = BirthdayViewModel(ageValidator: ageValidator)
            
            let validDate = Date()
            let expectation = self.expectation(description: "Completion handler called")
            
            viewModel.onSelectBirthdayDate(selectedDate: validDate) { result in
                switch result {
                case .success(let date):
                    XCTAssertEqual(date, validDate)
                case .failure:
                    XCTFail("Expected success, but got failure")
                }
                expectation.fulfill()
            }
            
            waitForExpectations(timeout: 1.0, handler: nil)
        }
        
        func testOnSelectBirthdayDate_withInvalidDate() {
            let ageValidator = MockAgeValidator()
            ageValidator.isValid = false
            
            let viewModel = BirthdayViewModel(ageValidator: ageValidator)
            
            let invalidDate = Date()
            let expectation = self.expectation(description: "Completion handler called")
            
            viewModel.onSelectBirthdayDate(selectedDate: invalidDate) { result in
                switch result {
                case .success:
                    XCTFail("Expected failure, but got success")
                case .failure(let error):
                    XCTAssertTrue(error is UserAgeValidationError)
                }
                expectation.fulfill()
            }
            
            waitForExpectations(timeout: 1.0, handler: nil)
        }
    
}

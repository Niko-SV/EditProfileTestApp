//
//  MainViewModelTests.swift
//  EditProfileTests
//
//  Created by NikoS on 23.07.2024.
//

import XCTest
@testable import EditProfile
import CoreData

class MainViewModelTests: XCTestCase {
    
    var mockCoreDataStack: MockCoreDataStack!
    var mockUserFieldsValidator: MockUserFieldsValidator!
    var mainViewModel: MainViewModel!
    
    override func setUp() {
        super.setUp()
        mockCoreDataStack = MockCoreDataStack()
        mockUserFieldsValidator = MockUserFieldsValidator()
        mainViewModel = MainViewModel(
            context: mockCoreDataStack.mainContext,
            userFieldsValidator: mockUserFieldsValidator)
    }
    
    override func tearDown() {
        mainViewModel = nil
        mockUserFieldsValidator = nil
        mockCoreDataStack = nil
        super.tearDown()
    }
    
    func testFetchProfileAfterSaveSuccess() {
            let saveExpectation = self.expectation(description: "Save profile success")
            let fetchExpectation = self.expectation(description: "Fetch profile success")
            
            mockUserFieldsValidator.validationFields = []
            
            let image = UIImage()
            let fullName = "Test User"
            let birthday = Date()
            let gender = "Male"
            let email = "test@example.com"
            let phoneNumber = "1234567890"
            
            mainViewModel.saveProfile(
                image: image,
                fullName: fullName,
                birthday: birthday.convertToString(),
                gender: gender,
                email: email,
                phoneNumber: phoneNumber
            ) { result in
                switch result {
                case .success:
                    self.mainViewModel.fetchProfile { model in
                        XCTAssertNotNil(model, "Expected profile to be fetched")
                        XCTAssertEqual(model?.email, email, "Email should match")
                        print("Fetched profile: \(String(describing: model))")
                        fetchExpectation.fulfill()
                    }
                case .failure(let error):
                    XCTFail("Expected success, but got failure with error: \(error)")
                }
                saveExpectation.fulfill()
            }
            
            wait(for: [saveExpectation, fetchExpectation], timeout: 1.0)
        }
    
    func testFetchProfileFailure() {
        let expectation = self.expectation(description: "Fetch profile failure")
        
        let fetchRequest: NSFetchRequest<ProfileCoreDataModel> = ProfileCoreDataModel.fetchRequest()
        let profiles = try? mockCoreDataStack.mainContext.fetch(fetchRequest)
        XCTAssertTrue(profiles?.isEmpty ?? false, "The Core Data context should be empty for this test")
        
        mainViewModel.fetchProfile { model in
            XCTAssertNil(model, "Expected no profile to be fetched")
            print("Fetch profile failure with model: \(String(describing: model))")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testSaveProfileWithValidationErrors() {
        let expectation = self.expectation(description: "Save profile with validation errors")
        
        mockUserFieldsValidator.validationFields = [.email]
        
        mainViewModel.saveProfile(
            image: nil,
            fullName: "Test User",
            birthday: Date().convertToString(),
            gender: "Male",
            email: "invalid-email",
            phoneNumber: "1234567890"
        ) { result in
            switch result {
            case .success:
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                XCTAssertTrue(error is UserValidationError)
                let validationError = error as! UserValidationError
                XCTAssertEqual(validationError.fields, [.email])
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testSaveProfileSuccess() {
            let expectation = self.expectation(description: "Save profile success")
            
            mockUserFieldsValidator.validationFields = []
            
            let image = UIImage()
            let fullName = "Test User"
            let birthday = Date().convertToString()
            let gender = "Male"
            let email = "test@example.com"
            let phoneNumber = "1234567890"
            
            mainViewModel.saveProfile(
                image: image,
                fullName: fullName,
                birthday: birthday,
                gender: gender,
                email: email,
                phoneNumber: phoneNumber
            ) { result in
                switch result {
                case .success(let model):
                    XCTAssertEqual(model.image, image)
                    XCTAssertEqual(model.email, email)
                    XCTAssertEqual(model.birthday, birthday.convertToDate())
                    XCTAssertEqual(model.gender, gender)
                    XCTAssertEqual(model.fullName, fullName)
                    XCTAssertEqual(model.phoneNumber, phoneNumber)
                    print("Save profile success with model: \(model)")
                case .failure(let error):
                    XCTFail("Expected success, but got failure with error: \(error)")
                }
                expectation.fulfill()
            }
            
            waitForExpectations(timeout: 1.0, handler: nil)
        }
}

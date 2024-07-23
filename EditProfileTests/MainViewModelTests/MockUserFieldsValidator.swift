//
//  MockUserFieldsValidator.swift
//  EditProfileTests
//
//  Created by NikoS on 23.07.2024.
//

import CoreData
import UIKit
@testable import EditProfile

class MockUserFieldsValidator: UserFieldsValidator {
    var validationFields: Array<UserValidationError.Field> = []
    
    override func validate(
        image: UIImage?,
        fullName: String?,
        birthday: String?,
        gender: String?,
        email: String?,
        phoneNumber: String?)
    -> Array<UserValidationError.Field> {
        return validationFields
    }
}

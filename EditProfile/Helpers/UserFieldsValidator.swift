//
//  UserFieldsValidator.swift
//  EditProfile
//
//  Created by NikoS on 15.07.2024.
//

import UIKit

class UserFieldsValidator {
    
    open func validate(
        image: UIImage?,
        fullName: String?,
        birthday: String?,
        gender: String?,
        email: String?,
        phoneNumber: String?
    ) -> Array<UserValidationError.Field> {
        
        var validationFields: Array<UserValidationError.Field> = []
        
        if image == nil {
            validationFields.append(.image)
        }
        if fullName == nil
            || fullName!.isEmpty
            || !isFieldValid(AppConstants.fullNameRegex, fullName) {
            validationFields.append(.fullName)
        }
        if birthday == nil 
            || birthday?.convertToDate() == nil {
            validationFields.append(.birthday)
        }
        if gender == nil 
            || gender!.isEmpty {
            validationFields.append(.gender)
        }
        if email == nil 
            || email!.isEmpty
            || !isFieldValid(AppConstants.emailRegex, email) {
            validationFields.append(.email)
        }
        if phoneNumber == nil 
            || phoneNumber!.isEmpty
            || !isFieldValid(AppConstants.phoneNumberRegex, phoneNumber) {
            validationFields.append(.phoneNumber)
        }
        
        return validationFields
    }
    
    private func isFieldValid(_ regex: String,_ field: String?) -> Bool {
        let fieldPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return fieldPredicate.evaluate(with: field)
    }
}

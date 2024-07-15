//
//  UserValidationError.swift
//  EditProfile
//
//  Created by NikoS on 15.07.2024.
//

import Foundation


struct UserValidationError: Error {
    
    let fields: Array<Field>
    
    enum Field {
        case fullName
        case birthday
        case phoneNumber
        case gender
        case email
        case image
    }
}

//
//  UserUI.swift
//  EditProfile
//
//  Created by NikoS on 15.07.2024.
//
import UIKit

struct ProfileFormDataModel {
    var image: UIImage
    var fullName: String
    var birthday: Date
    var gender: String
    var email: String
    var phoneNumber: String
    
    func getBirthdayLabel() -> String {
        return birthday.convertToString()
    }
    
    func getNickname() -> String {
        let username = fullName.replacingOccurrences(of: " ", with: "").lowercased()
        return "@\(username)"
    }
}

extension ProfileFormDataModel {
    init(entity: ProfileCoreDataModel) {
        self.image = entity.photo
        self.fullName = entity.name
        self.birthday = entity.birthday
        self.gender = entity.gender
        self.email = entity.mail
        self.phoneNumber = entity.phoneNumber
    }
}

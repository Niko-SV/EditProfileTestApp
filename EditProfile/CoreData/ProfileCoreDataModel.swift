//
//  Profile.swift
//  EditProfile
//
//  Created by NikoS on 13.07.2024.
//

import Foundation
import CoreData
import UIKit

@objc(Profile)
class Profile: NSManagedObject {}

extension Profile {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: AppConstants.profileCoreDataModelName)
    }

    @NSManaged public var birthday: Date
    @NSManaged public var gender: String
    @NSManaged public var mail: String
    @NSManaged public var name: String
    @NSManaged public var phoneNumber: String
    @NSManaged public var photo: UIImage

}

extension Profile : Identifiable {}

extension Profile {
    func update(with model: ProfileFormDataModel) {
        self.photo = model.image
        self.mail = model.email
        self.phoneNumber = model.phoneNumber
        self.gender = model.gender
        self.birthday = model.birthday
        self.name = model.fullName
    }
}

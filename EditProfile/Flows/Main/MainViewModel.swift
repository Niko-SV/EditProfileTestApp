//
//  ViewModel.swift
//  EditProfile
//
//  Created by NikoS on 13.07.2024.
//

import Foundation
import UIKit
import CoreData

class MainViewModel {
    
    private var context: NSManagedObjectContext
    private let userFieldsValidator: UserFieldsValidator
    
    var model: ProfileFormDataModel? = nil
    
    init(context: NSManagedObjectContext = CoreDataStack.shared.mainContext, userFieldsValidator: UserFieldsValidator = UserFieldsValidator()) {
        self.context = context
        self.userFieldsValidator = userFieldsValidator
    }
    
    func fetchProfile(completion: @escaping (ProfileFormDataModel?) -> Void) {
        let request: NSFetchRequest<ProfileCoreDataModel> = NSFetchRequest(entityName: AppConstants.profileCoreDataModelName)
        do {
            let profiles: [ProfileCoreDataModel] = try context.fetch(request)
            if let profile = profiles.last {
                let model = ProfileFormDataModel(entity: profile)
                self.model = model
                completion(model)
            } else {
                completion(nil)
            }
        } catch {
            print(error)
        }
    }
    
    func saveProfile(
        image: UIImage?,
        fullName: String?,
        birthday: String?,
        gender: String?,
        email: String?,
        phoneNumber: String?,
        completion: @escaping (Result<ProfileFormDataModel, Error>) -> Void
    ) {
        let errors = userFieldsValidator.validate(
            image: image,
            fullName: fullName,
            birthday: birthday,
            gender: gender,
            email: email,
            phoneNumber: phoneNumber)
        
        guard errors.isEmpty else {
            completion(.failure(UserValidationError(fields: errors)))
            return
        }
        
        DispatchQueue.main.async {
            if let fullName = fullName,
               let image = image,
               let birthdayString = birthday,
               let birthdayDate = birthdayString.convertToDate(),
               let gender = gender,
               let email = email,
               let phoneNumber = phoneNumber {
                let model = ProfileFormDataModel(
                    image: image,
                    fullName: fullName,
                    birthday: birthdayDate,
                    gender: gender,
                    email: email,
                    phoneNumber: phoneNumber)
                
                self.fetchOrCreateProfile(
                    model: model,
                    completion: completion)
            }
        }
    }
    
    private func fetchOrCreateProfile(model: ProfileFormDataModel, completion: @escaping (Result<ProfileFormDataModel, Error>)  -> Void) {
        let fetchRequest: NSFetchRequest<ProfileCoreDataModel> = ProfileCoreDataModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "mail == %@", model.email)
        
        do {
            let profiles = try self.context.fetch(fetchRequest)
            
            let profile: ProfileCoreDataModel
            if let existingProfile = profiles.first {
                profile = existingProfile
            } else {
                profile = ProfileCoreDataModel(context: self.context)
            }
            profile.update(with: model)
            try self.context.save()
            
            completion(.success((model)))
        } catch {
            print("Failed to fetch or create profile: \(error)")
            completion(.failure(error))
        }
    }
}

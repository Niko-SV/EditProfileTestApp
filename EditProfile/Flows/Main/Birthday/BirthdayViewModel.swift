//
//  BirthdayViewModel.swift
//  EditProfile
//
//  Created by NikoS on 15.07.2024.
//

import UIKit

class BirthdayViewModel {
    
    private var ageValidator = AgeValidator()
    
    func onSelecrBirthdayDate(selectedDate: Date?, completion: @escaping (Result<Date, Error>) -> Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
      
        guard let selectedDate = selectedDate else { return }
        
        if ageValidator.isAgeValid(selectedDate: selectedDate) {
            completion(.success(selectedDate))
        } else {
            completion(.failure(UserAgeValidationError()))
        }
    }
    
}

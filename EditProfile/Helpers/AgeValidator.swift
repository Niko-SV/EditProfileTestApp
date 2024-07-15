//
//  AgeValidator.swift
//  EditProfile
//
//  Created by NikoS on 15.07.2024.
//

import UIKit

class AgeValidator {
    
    func isAgeValid(selectedDate: Date) -> Bool {
        let today = Date()
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: selectedDate, to: today)
        let age = ageComponents.year ?? 0
        
        return age >= 18
    }
    
}

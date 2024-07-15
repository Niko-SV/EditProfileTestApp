//
//  Date.swift
//  EditProfile
//
//  Created by NikoS on 15.07.2024.
//

import Foundation

extension Date {
    
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = AppConstants.datePattern
        
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
}

//
//  String.swift
//  EditProfile
//
//  Created by NikoS on 15.07.2024.
//

import Foundation

extension String {
    
    func convertToDate() -> Date? {
        guard !self.isEmpty else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = AppConstants.datePattern
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            print("Failed to parse date from string: \(self)")
            return nil
        }
    }
    
}

//
//  BaseAlert.swift
//  EditProfile
//
//  Created by NikoS on 15.07.2024.
//

import UIKit

class BaseAlert {
    
    static func createBaseAlert(title: String, message: String, actionTitle: String) -> UIAlertController {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        alert.addAction(
            UIAlertAction(
                title: actionTitle,
                style: .default,
                handler: nil)
        )
        return alert
    }
    
}

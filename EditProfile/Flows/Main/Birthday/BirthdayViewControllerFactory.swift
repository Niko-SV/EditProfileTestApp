//
//  BirthdayViewControllerFactory.swift
//  EditProfile
//
//  Created by NikoS on 17.07.2024.
//

import UIKit

enum BirthdayViewControllerFactory {
    
    static func storyboardName() -> String {
        "Birthday"
    }
    
    static func storyboardBundle() -> Bundle {
        return Bundle(for: BirthdayViewController.self)
    }
    
    static func storyboard() -> UIStoryboard {
        let name = storyboardName()
        let bundle = storyboardBundle()
        let storyboard = UIStoryboard(
            name: name,
            bundle: bundle)
        return storyboard
    }
    
    static func instantiate() -> BirthdayViewController {
        let controller: BirthdayViewController = storyboard().instantiateViewController()
        
        return controller
    }
    
}

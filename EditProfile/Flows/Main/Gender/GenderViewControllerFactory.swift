//
//  GenderViewControllerFactory.swift
//  EditProfile
//
//  Created by NikoS on 17.07.2024.
//

import UIKit

enum GenderViewControllerFactory {
    
    static func storyboardName() -> String {
        "Gender"
    }
    
    static func storyboardBundle() -> Bundle {
        return Bundle(for: GenderViewController.self)
    }
    
    static func storyboard() -> UIStoryboard {
        let name = storyboardName()
        let bundle = storyboardBundle()
        let storyboard = UIStoryboard(
            name: name,
            bundle: bundle)
        return storyboard
    }
    
    static func instantiate() -> GenderViewController {
        let controller: GenderViewController = storyboard().instantiateViewController()
        
        return controller
    }
    
}

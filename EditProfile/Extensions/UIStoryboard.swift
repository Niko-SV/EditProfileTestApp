//
//  UIStoryboard.swift
//  EditProfile
//
//  Created by NikoS on 17.07.2024.
//

import UIKit

public extension UIStoryboard {

    func instantiateViewController<T: UIViewController>(
        ofType type: T.Type = T.self, customIdentifier: String? = nil) -> T {

        let identifier = customIdentifier ?? String(describing: type)

        let viewController = instantiateViewController(withIdentifier: identifier) as! T

        return viewController
    }
}

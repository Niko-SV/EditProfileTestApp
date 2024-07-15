//
//  UIVIew.swift
//  EditProfile
//
//  Created by NikoS on 13.07.2024.
//

import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    public func setError() {
        self.layer.borderColor = UIColor.red.cgColor
    }
    
    public func clearErrorTextField() {
        self.layer.borderColor = UIColor.systemGray2.cgColor
    }
    
    public func clearErrorImage() {
        self.layer.borderColor = UIColor.clear.cgColor
    }
    
}


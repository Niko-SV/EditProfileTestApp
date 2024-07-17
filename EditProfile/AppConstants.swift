//
//  AppConstants.swift
//  EditProfile
//
//  Created by NikoS on 14.07.2024.
//

import Foundation

struct AppConstants {
    
    static let profileCoreDataModelName = "ProfileCoreDataModel"
    
    static let genderOptions = ["Male", "Female", "Prefer not to say"]
    
    static let datePattern = "dd-MM-yyyy"
    
    static let phoneNumberRegex = "^\\(\\+\\d{3}\\) \\d{8,9}$"
    static let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}$"
    static let fullNameRegex = "^[A-Za-z ]+$"
    
    static let imagePickerTitle = "Choose Image"
    static let cameraTitle = "Camera"
    static let galleryTitle = "Gallery"
    static let cancelTitle = "Cancel"
    
    static let imageSizeErrorMessage = "Image size exceeds 2 MB. Please choose a smaller image."
    
    static let ageValidationAlertTitleText = "Age Validation"
    static let ageValidationAlertErrorText = "You must be 18 years or older to proceed."
    
    static let savedProfileAlertTitleText = "Profile saved"
    static let savedProfileAlertMessageText = "Your profile was saved. Thanks."
    
    static let photoLibraryAlertErrorText = "Photo Library not available"
    static let cameraAlertErrorText = "Camera not available"
    
    static let alertErrorTitle = "Error"
    static let alertOkText = "OK"
    
    static let imageSize = 2048
    static let imageSide = 100
    
    static let uiImageTransformerName = "UIImageTransformer"
}

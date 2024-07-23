//
//  BirthdayViewController.swift
//  EditProfile
//
//  Created by NikoS on 14.07.2024.
//

import UIKit

protocol BirthdayViewControllerDelegate: AnyObject {
    func didSelectDate(date: Date)
}

class BirthdayViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    
    weak var delegate: BirthdayViewControllerDelegate?

    private var viewModel = BirthdayViewModel()

    @IBAction func saveButtonTapped(_ sender: Any) {
        let selectedDate = datePicker.date
        viewModel.onSelectBirthdayDate(selectedDate: selectedDate, completion: { result in
            switch result {
            case .success(let date):
                self.delegate?.didSelectDate(date: date)
                self.dismiss(animated: true, completion: nil)
            case .failure(let error):
                if let userValidationError = error as? UserAgeValidationError {
                    let alert = BaseAlert.createBaseAlert(
                        title: AppConstants.ageValidationAlertTitleText,
                        message: AppConstants.ageValidationAlertErrorText,
                        actionTitle: AppConstants.alertOkText)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    print("Catch error: \(error)")
                }
            }
        })
    }
}

//
//  GenderViewController.swift
//  EditProfile
//
//  Created by NikoS on 14.07.2024.
//

import UIKit

protocol GenderViewControllerDelegate: AnyObject {
    func didSelectGender(gender: String)
}

class GenderViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var saveButton: UIButton!
    
    weak var delegate: GenderViewControllerDelegate?

    var selectedGender: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let selectedGender = selectedGender {
            delegate?.didSelectGender(gender: selectedGender)
        } else {
            delegate?.didSelectGender(gender: AppConstants.genderOptions[0])
        }
        dismiss(animated: true, completion: nil)
    }
    
}

    // MARK: - Delegate, DataSource methods
extension GenderViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return AppConstants.genderOptions.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return AppConstants.genderOptions[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGender = AppConstants.genderOptions[row]
    }
}

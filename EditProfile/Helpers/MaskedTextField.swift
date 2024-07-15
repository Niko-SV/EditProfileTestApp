//
//  MaskedTextField.swift
//  EditProfile
//
//  Created by NikoS on 15.07.2024.
//

import UIKit

class MaskedTextField: UITextField {
    
    private var previousText: String?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        delegate = self
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    
    @objc private func editingChanged() {
        guard let text = text else { return }
        
        let cleanedText = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        var formattedText = ""
        let maxDigitsInOperatorCode = 3
        let maxTotalDigits = maxDigitsInOperatorCode + 9
        
        for (index, character) in cleanedText.enumerated() {
            if index == 0 {
                formattedText += "(+"
            } else if index == maxDigitsInOperatorCode {
                formattedText += ") "
            } else if index == maxTotalDigits {
                break
            }
            
            formattedText.append(character)
        }
        
        self.text = formattedText
    }
}


extension MaskedTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard !string.isEmpty else {
            return true
        }
        
        let validCharacters = CharacterSet.decimalDigits
        if string.rangeOfCharacter(from: validCharacters.inverted) != nil {
            return false
        }
        
        guard let currentText = textField.text else { return true }
        let newLength = currentText.count + string.count - range.length
        return newLength <= 14
    }
}

//
//  ViewController.swift
//  EditProfile
//
//  Created by NikoS on 13.07.2024.
//

import UIKit

class MainViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pickImageButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var mainInfoView: UIView!
    @IBOutlet weak var fullNameTitleLabel: UILabel!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var genderTitleLabel: UILabel!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var birthdayView: UIView!
    @IBOutlet weak var birthdayTitleView: UILabel!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var phoneNumberTitleLabel: UILabel!
    @IBOutlet weak var phoneNumberTextField: MaskedTextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTitleLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var genderPickerButton: UIButton!
    @IBOutlet weak var birthdayPickerButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var viewModel: MainViewModel = MainViewModel()
    
    private var pickedImage: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullNameTextField.delegate = self
        phoneNumberTextField.delegate = self
        emailTextField.delegate = self
        
        viewModel.fetchProfile(completion: { [weak self] profile in
            self?.pickedImage = profile.image
            self?.imageView.image = profile.image
            self?.nameLabel.text = profile.fullName
            self?.nicknameLabel.text = profile.getNickname()
            self?.fullNameTextField.text = profile.fullName
            self?.birthdayTextField.text = profile.getBirthdayLabel()
            self?.genderTextField.text = profile.gender
            self?.phoneNumberTextField.text = profile.phoneNumber
            self?.emailTextField.text = profile.email
        })
        
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: view,
                action: #selector(UIView.endEditing(_:))
            )
        )
        addKeyboardObservers()
    }
    
    @IBAction func genderButtonTapped(_ sender: Any) {
        view.endEditing(true)
        genderView.clearErrorTextField()
        let storyboard = UIStoryboard(name: "Gender", bundle: nil)
        if let modalVC = storyboard.instantiateViewController(withIdentifier: "GenderViewController") as? GenderViewController {
            modalVC.delegate = self
            present(modalVC, animated: true, completion: nil)
        } else {
            print("GenderViewController could not be instantiated from storyboard.")
        }
    }
    
    @IBAction func birthdayButtonTapped(_ sender: Any) {
        view.endEditing(true)
        birthdayView.clearErrorTextField()
        let storyboard = UIStoryboard(name: "Birthday", bundle: nil)
        if let modalVC = storyboard.instantiateViewController(withIdentifier: "BirthdayViewController") as? BirthdayViewController {
            modalVC.delegate = self
            present(modalVC, animated: true, completion: nil)
        } else {
            print("GenderViewController could not be instantiated from storyboard.")
        }
    }
    
    @IBAction func pickImageButtonTapped(_ sender: Any) {
        imageView.clearErrorImage()
        let alert = UIAlertController(
            title: AppConstants.imagePickerTitle,
            message: nil,
            preferredStyle: .actionSheet)
        
        alert.addAction(
            UIAlertAction(
                title: AppConstants.cameraTitle,
                style: .default, handler: { _ in
                    self.openCamera()
                }))
        alert.addAction(
            UIAlertAction(
                title: AppConstants.galleryTitle,
                style: .default, handler: { _ in
                    self.openGallery()
                }))
        alert.addAction(
            UIAlertAction.init(
                title: AppConstants.cancelTitle,
                style: .cancel,
                handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        self.viewModel.saveProfile(
            image: pickedImage,
            fullName: self.fullNameTextField.text,
            birthday: self.birthdayTextField.text,
            gender: self.genderTextField.text,
            email: self.emailTextField.text,
            phoneNumber: self.phoneNumberTextField.text
        ) {  [weak self] result in
            switch result {
            case .success(let model):
                self?.onSaveProfileSuccess(model: model)
            case .failure(let error):
                self?.onSaveProfileError(error: error)
            }
        }
    }
    
    private func onSaveProfileSuccess(model: ProfileFormDataModel) {
        self.nameLabel.text = model.fullName
        self.nicknameLabel.text = model.getNickname()
    }
    
    private func onSaveProfileError(error: Error) {
        if let userValidationError = error as? UserValidationError {
            userValidationError.fields.forEach {[weak self] error in
                switch error {
                case .fullName:
                    self?.mainInfoView.setError()
                case .birthday:
                    self?.birthdayView.setError()
                case .phoneNumber:
                    self?.phoneNumberView.setError()
                case .gender:
                    self?.genderView.setError()
                case .email:
                    self?.emailView.setError()
                case .image:
                    self?.imageView.setError()
                }
            }
        }
    }
    
    deinit {
        removeKeyboardObservers()
    }
}

// MARK: - Delegates

extension MainViewController: GenderViewControllerDelegate {
    func didSelectGender(gender: String) {
        genderTextField.text = gender
    }
}

extension MainViewController: BirthdayViewControllerDelegate {
    func didSelectDate(date: Date) {
        birthdayTextField.text = date.convertToString()
    }
}

    // MARK: - Keyboard handling

extension MainViewController: UITextFieldDelegate {
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        var keyboardFrame = keyboardSize.cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let parentView = textField.superview {
            parentView.clearErrorTextField()
        }
        return true
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        self.scrollView.contentInset = .zero
    }
    
    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
        view.gestureRecognizers?.forEach {
            if $0 is UITapGestureRecognizer {
                view.removeGestureRecognizer($0)
            }
        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Photo picker

extension MainViewController: UIImagePickerControllerDelegate {
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert = BaseAlert.createBaseAlert(
                title: AppConstants.alertErrorTitle,
                message: AppConstants.cameraAlertErrorText,
                actionTitle: AppConstants.alertOkText)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert = BaseAlert.createBaseAlert(
                title: AppConstants.alertErrorTitle,
                message: AppConstants.photoLibraryAlertErrorText,
                actionTitle: AppConstants.alertOkText)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            guard let imageData = pickedImage.jpegData(compressionQuality: 1.0) else { return }
            
            let imageSize = imageData.count / 1024
            if imageSize > AppConstants.imageSize {
                let alert = BaseAlert.createBaseAlert(
                    title: AppConstants.alertErrorTitle,
                    message: AppConstants.imageSizeErrorMessage,
                    actionTitle: AppConstants.alertOkText)
                picker.dismiss(animated: true, completion: {
                    self.present(alert, animated: true, completion: nil)
                })
                return
            }
            
            let croppedImage = cropImageToCircle(
                image: pickedImage,
                size: CGSize(
                    width: AppConstants.imageSide,
                    height: AppConstants.imageSide)
            )
            
            self.pickedImage = pickedImage
            imageView.image = croppedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func cropImageToCircle(image: UIImage, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        
        _ = UIGraphicsGetCurrentContext()!
        let path = UIBezierPath(
            ovalIn: CGRect(
                origin: .zero,
                size: size)
        )
        path.addClip()
        image.draw(in: CGRect(origin: .zero, size: size))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        return newImage!
    }
}
